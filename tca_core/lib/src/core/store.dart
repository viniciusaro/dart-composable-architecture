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

mixin Disposable {
  void dispose();
}

mixin InitializableState<T> {
  T init();
}

final class StateUpdate<State> {
  final State state;
  final bool fromChild;
  const StateUpdate(this.state, this.fromChild);
}

final class Store<State, Action> with Disposable {
  final Inout<State> _state;
  State get state => _state._value;
  final Reducer<State, Action> _reducer;
  final syncStream = SyncStream<State>();
  void Function()? onDispose;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
    this.onDispose,
  })  : _state = initialState is InitializableState
            ? Inout(value: initialState.init())
            : Inout(value: initialState),
        _reducer = reducer {
    syncStream.setInitialValue(_state.value);
  }

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
    onDispose?.call();
  }
}

extension StoreView<State, Action> on Store<State, Action> {
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

  void receive(Action action, State Function(State) expectedStateUpdate) {
    _expectedActions.add(action);
    _expectedStateUpdates.add(expectedStateUpdate);
  }

  void verifyNoPendingActions() {
    if (_expectedActions.isNotEmpty || _expectedStateUpdates.isNotEmpty) {
      throw UnexpectedPendingActions(pendingActions: _expectedActions);
    }
  }
}
