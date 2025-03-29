import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/sync_stream.dart';
import 'navigation.dart';
import 'shared.dart';

part 'exceptions.dart';
part 'effect.dart';
part 'feature.dart';
part 'inout.dart';
part 'key_path.dart';
part 'reducer.dart';

/// A type that contains a [dispose] method.
///
/// Useful for types that are really coupled to the runtime
/// of a feature and might need to clean up resources
/// before they are garbage collected.
mixin Disposable {
  /// Should be called whenever the lifecycle of the object is finished
  /// and it will be garbage collected soon.
  ///
  /// For example [NavigationDestination] calls this method right
  /// when `onDidRemovePage` is called, allowing
  /// state cleanup to happen automatically
  /// for [Store]s.
  void dispose();
}

/// [Store]s are the runtime for Composable Architecture features.
///
/// They are responsible for receiving and computing [Action]s by
/// running [Reducer]s, which produce [Effect]s.
///
/// Stores subscribe to effects and handle they lifecycle and
/// possible actions that may be produced, computing them as well.
///
/// They are also observable and can be used on UI frameworks such
/// as Flutter, allowing recomputing visual elements when
/// state changes.
///
/// Composability is also a core functionality. One can write full
/// isolated features and use the `view` method to derive new
/// stores that are scoped in a specific set of state and action.
final class Store<State, Action> with Disposable {
  final Inout<State> _state;

  /// The current value hold by the [Store]. This value changes
  /// mostly everytime the [send] method is called with
  /// a new action.
  State get state => _state._value;
  final Reducer<State, Action> _reducer;

  /// A [Stream] like implementation that can be used wherever needs
  /// to update when new [State] is emited.
  final syncStream = SyncStream<State>();
  final void Function()? _onDispose;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
    void Function()? onDispose,
  })  : _state = Inout(value: initialState),
        _reducer = reducer,
        _onDispose = onDispose {
    syncStream.setInitialValue(_state.value);
  }

  /// Receives an [Action] as parameter, runs it on the inner [Reducer]
  /// and handles [Effect]s that might be produced.
  ///
  /// State updates are notified by the [syncStream] property.
  void send(Action action) {
    final effect = runZoned(
      () {
        _state._isMutationAllowed = true;
        final effect = _reducer.run(_state, action);
        _state._isMutationAllowed = false;
        syncStream.add(_state._value);
        return effect;
      },
      zoneValues: {
        #sharedZoneValues: SharedZoneValues()..didRunSharedSet = false,
      },
    );

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  @override
  void dispose() {
    _onDispose?.call();
  }
}

extension StoreView<State, Action> on Store<State, Action> {
  /// Allows scoping this store in a local one.
  ///
  /// This is one of the pillars that enable feature isolation
  /// while maintaining testability.
  ///
  /// [state] parameter allows the viewed store to extract a local
  /// state from the parent state to start a new [Store] instance.
  ///
  /// [action] parameter allows local actions to be transformed
  /// in global actions and the parent reducer can run
  /// and update both local and global states.
  ///
  /// The store derived from [view] and the original store are
  /// keept in sync when this method is invoked. This means
  /// that, even though we are working with immutable types,
  /// their state is updated when changes happens
  /// in both ways.
  Store<LocalState, LocalAction> view<LocalState, LocalAction>({
    required WritableKeyPath<State, LocalState> state,
    required WritableKeyPath<Action, LocalAction?> action,
  }) {
    final store = Store<LocalState, LocalAction>(
      initialState: state.get(this.state),
      reducer: Reduce((localState, localAction) {
        final globalAction = action.set(null, localAction);
        if (globalAction != null) {
          send(globalAction);
        }
        return Effect.none();
      }),
    );

    syncStream.listen((update) {
      store._state._isMutationAllowed = true;
      store._state.mutate((_) => state.get(update));
      store._state._isMutationAllowed = false;
      store.syncStream.add(state.get(update));
    });

    return store;
  }
}

extension StorePresentable<State extends Presentable, Action>
    on Store<State, Action> {
  /// Special implementation of [view] for [Presentable] states.
  ///
  /// This implementation do extra work by setting root action
  /// to `null` when the derived store is disposed.
  ///
  /// It is mostly used by [NavigationDestination] widget, where
  /// an optional store can be used to define if the
  /// destination should be navigated to or not.
  Store<LocalState, LocalAction>? view<LocalState, LocalAction>({
    required WritableKeyPath<State, LocalState?> state,
    required WritableKeyPath<Action, LocalAction?> action,
  }) {
    final initialState = state.get(this.state);
    if (initialState == null) {
      return null;
    }

    final store = Store<LocalState, LocalAction>(
      initialState: initialState,
      reducer: Reduce((localState, localAction) {
        final globalAction = action.set(null, localAction);
        if (globalAction != null) {
          send(globalAction);
        }
        return Effect.none();
      }),
      onDispose: () {
        _state._isMutationAllowed = true;
        _state.mutate((s) => state.set(s, null));
        _state._isMutationAllowed = false;
        syncStream.add(this.state);
      },
    );

    syncStream.listen((update) {
      final localUpdate = state.get(update);
      if (localUpdate != null) {
        store._state._isMutationAllowed = true;
        store._state.mutate((s) => localUpdate);
        store._state._isMutationAllowed = false;
        store.syncStream.add(localUpdate);
      } else {
        // ?
      }
    });

    return store;
  }
}

/// This special store must be used for unit testing [Feature]s written
/// with the Composable Architecture.
///
/// To verify state changes that are results to sending actions one can
/// call the [send] method.
///
/// Different from a normal [Store], this method also receives a closure
/// that, given the current instance of [State], must return
/// a new [State] with the respective changes that should
/// be applied by sending [Action].
///
/// The [send] method makes many checks to make sure [Feature] implementation
/// follows some important principles.
/// - Immutability: if the mutation happens in the same instance when the
///   reducer is run, this store throws a [MutationOfSameInstance] exception.
/// - Exaustivity: the closure passed to [send] must contain all expected
///   changes made to state when sending [Action]. If equality
///   checks do not hold, the store throws a
///   [UnexpectedChanges] exception.
///
/// [Reducer]s might return [Effect]s, which can produce new [Action]s.
/// If that is the case, this store also makes sure this is
/// taken into account when writing a unit test.
/// In that case it throws an [UnexpectedAction] exception, unless [receive]
/// is called after [send].
///
/// [receive] will tell [TestStore] that an action is expected and, once
/// it is received, the store verifies if there is an expected
/// action registered.
///
/// ```dart
/// @freezed
/// final class NumberFactState with _$NumberFactState {
///   @override
///   final bool isLoading;
///
///   @override
///   final String? numberFact;
///   NumberFactState({required this.numberFact});
/// }
///
/// @CaseKeyPathable()
/// sealed class NumberFactAction<
///   NumberFactButtonTapped extends int,
///   NumberFactResponse extends String
/// > {}
///
/// final class NumberFactFeature extends Feature<NumberFactState, NumberFactAction> {
///   @override
///   Reducer<NumberFactState, NumberFactAction> build() {
///     return Reduce((state, action) {
///       switch (action) {
///         case NumberFactActionNumberFactButtonTapped():
///           state.mutate((s) => s.copyWith(isLoading: true);
///           return Effect.future(() async {
///             final response = await factClient.factFor(action.numberFactButtonTapped);
///             return NumberFactActionEnum.numberFactResponse(response);
///           });
///         case NumberFactActionNumberFactResponse():
///           state.mutate((s) => s.copyWith(
///             isLoading: false,
///             numberFact: action.numberFactResponse
///           );
///           return Effect.none();
///       }
///     });
///   }
/// }
/// ```
///
/// Unit tests will look like the following:
///
/// ```dart
/// test('number fact button tap updates state with response when received', () {
///   factClient = NumberFactClient(
///     factFor: (n) async => "$n is a good number",
///   );
///
///   final store = TestStore(
///     initialState: NumberFactState(),
///     reducer: NumberFactFeature()
///   );
///
///   store.send(
///     NumberFactActionEnum.numberFactButtonTapped(5),
///     (state) => state.copyWith(isLoading: true),
///   );
///
///   store.receive(
///     NumberFactActionEnum.numberFactResponse("5 is a good number"),
///     (state) => state.copyWIth(isLoading: false, numberFact: "5 is a good number"),
///   )
/// });
///
/// ```
///
/// If any action other than the one registered with [receive] is received, the
/// store throws an [UnexpectedAction].
///
/// Similarly, [receive] receives a closure with the expected state changes
/// respective to the received action. If equality checks fails for
/// the expected changes, an [UnexpectedChanges]
/// execption is thrown.
final class TestStore<State, Action> {
  final Inout<State> _state;
  final Reducer<State, Action> _reducer;
  final List<Action> _expectedActions = [];
  final List<State Function(State)> _expectedStateUpdates = [];

  TestStore({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = Inout(value: initialState),
        _reducer = reducer;

  /// The [send] method makes many checks to make sure [Feature] implementation
  /// follows some important principles.
  /// - Immutability: if the mutation happens in the same instance when the
  ///   reducer is run, this store throws a [MutationOfSameInstance] exception.
  /// - Exaustivity: the closure passed to [send] must contain all expected
  ///   changes made to state when sending [Action]. If equality
  ///   checks do not hold, the store throws a
  ///   [UnexpectedChanges] exception.
  void send(Action action, State Function(State) expectedStateUpdate) {
    _state._isMutationAllowed = true;
    _state._didCallMutate = false;
    final stateRefBeforeReducer = _state.value;
    final expected = runZoned(
      () => expectedStateUpdate(_state.value),
      zoneValues: {#expectedStateClosure: true},
    );
    final effect = _reducer.run(_state, action);
    final updated = _state.value;
    _state._isMutationAllowed = false;

    if (_state._didCallMutate && identical(stateRefBeforeReducer, updated)) {
      throw MutationOfSameInstance();
    }

    if (!DeepCollectionEquality().equals(expected, updated)) {
      throw UnexpectedChanges(expected: expected, updated: updated);
    }

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen((action) {
      if (_expectedActions.isEmpty) {
        throw UnexpectedAction(action: action);
      }
      final expectedAction = _expectedActions.removeAt(0);
      final expectedUpdates = _expectedStateUpdates.removeAt(0);
      if (expectedAction != action) {
        throw UnexpectedAction(action: action);
      } else {
        _expectedActions.remove(action);
      }
      send(action, expectedUpdates);
    });

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  /// Registers that [action] will be received by [Store].
  ///
  /// See more at [TestStore].
  void receive(Action action, State Function(State) expectedStateUpdate) {
    _expectedActions.add(action);
    _expectedStateUpdates.add(expectedStateUpdate);
  }

  /// Utility method that should be called after sends
  void verifyNoPendingActions() {
    if (_expectedActions.isNotEmpty || _expectedStateUpdates.isNotEmpty) {
      throw UnexpectedPendingActions(pendingActions: _expectedActions);
    }
  }
}
