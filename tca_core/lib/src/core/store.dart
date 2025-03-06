import 'dart:async';

import '../helpers/sync_stream.dart';

part 'exceptions.dart';
part 'effect.dart';
part 'key_path.dart';
part 'reducer.dart';

final class StateUpdate<State> {
  final State state;
  final bool fromChild;
  const StateUpdate(this.state, this.fromChild);
}

final class Store<State, Action> {
  final Inout<State> _state;
  State get state => _state._value;
  final Reducer<State, Action> _reducer;
  final syncStream = SyncStream<StateUpdate<State>>();

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = Inout(value: initialState),
        _reducer = reducer;

  void send(Action action) {
    _send(action);
  }

  void _send(Action action, {bool fromChild = false}) {
    _state._isMutationAllowed = true;
    final effect = _reducer(_state, action);
    _state._isMutationAllowed = false;
    syncStream.add(StateUpdate(_state._value, fromChild));

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  Store<LocalState, LocalAction> view<LocalState, LocalAction>({
    required WritableKeyPath<State, LocalState> state,
    required WritableKeyPath<Action, LocalAction?> action,
  }) {
    final store = Store<LocalState, LocalAction>(
      initialState: state.get(this.state),
      reducer: (localState, localAction) {
        final globalAction = action.set(null, localAction);
        if (globalAction != null) {
          _send(globalAction, fromChild: true);
        }
        return Effect.none();
      },
    );

    syncStream.listen((update) {
      store._state._value = state.get(update.state);
      if (!update.fromChild) {
        store.syncStream.add(StateUpdate(state.get(update.state), false));
      }
    });

    return store;
  }
}

final class TestStore<State, Action> {
  final Inout<State> _state;
  final Reducer<State, Action> _reducer;
  final List<Action> _expectedActions = [];
  final List<State> _expectedStateUpdates = [];

  TestStore({required State initialState, required Reducer<State, Action> reducer})
      : _state = Inout(value: initialState),
        _reducer = reducer;

  void send(Action action, State expected) {
    _state._isMutationAllowed = true;
    final stateHashBeforeReducer = _state.value.hashCode;
    final stateRefBeforeReducer = _state.value;
    final effect = _reducer(_state, action);
    final stateRefAfterReducer = _state.value;
    final stateHashAfterReducer = _state.value.hashCode;

    if (stateHashBeforeReducer != stateHashAfterReducer &&
        identical(stateRefBeforeReducer, stateRefAfterReducer)) {
      throw Exception(
          "Mutation on same instance is not allowed. Reducers should make a copy of their state when mutation is needed");
    }

    _state._isMutationAllowed = false;

    final updated = _state.value;
    if (expected.hashCodeConsideringContents != updated.hashCodeConsideringContents) {
      throw Exception("Detected unexpected changes. Expected $expected, got: $updated");
    }

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen((action) {
      if (_expectedActions.isEmpty) {
        throw Exception("Received unexpected action: $action");
      }
      final expectedAction = _expectedActions.removeAt(0);
      final expectedUpdates = _expectedStateUpdates.removeAt(0);
      if (expectedAction != action) {
        throw Exception("Received unexpected action: $action");
      } else {
        _expectedActions.remove(action);
      }
      send(action, expectedUpdates);
    });

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  Future<void> receive(Action action, State expectedUpdate) async {
    _expectedActions.add(action);
    _expectedStateUpdates.add(expectedUpdate);
    await Future.delayed(Duration(milliseconds: 1));
  }
}

extension ObjectX<T> on T {
  int get hashCodeConsideringContents {
    final self = this;
    return self is Iterable ? Object.hashAll(self) : self.hashCode;
  }
}
