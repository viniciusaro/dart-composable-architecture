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
  final List<State Function(State)> _expectedStateUpdates = [];

  TestStore({required State initialState, required Reducer<State, Action> reducer})
      : _state = Inout(value: initialState),
        _reducer = reducer;

  void send(Action action, State Function(State) expectedStateUpdate) {
    _state._isMutationAllowed = true;
    _state._didCallMutate = false;
    final stateRefBeforeReducer = _state.value;
    final expected = expectedStateUpdate(_state.value);
    final effect = _reducer(_state, action);
    final stateRefAfterReducer = _state.value;

    if (_state._didCallMutate && identical(stateRefBeforeReducer, stateRefAfterReducer)) {
      throw MutationOfSameInstance();
    }

    _state._isMutationAllowed = false;

    final updated = _state.value;
    if (expected.hashCodeConsideringContents != updated.hashCodeConsideringContents) {
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

extension ObjectX<T> on T {
  int get hashCodeConsideringContents {
    final self = this;
    return self is Iterable ? Object.hashAll(self) : self.hashCode;
  }
}
