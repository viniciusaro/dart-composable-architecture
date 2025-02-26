import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

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
  final Reducer<State, Action> _reducer;
  final Inout<State> _state;
  State get state => _state._value;
  int _currentStateHash;
  final syncStream = SyncStream<StateUpdate<State>>();

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = Inout(value: initialState),
        _reducer = reducer,
        _currentStateHash = initialState.hashCode;

  void send(Action action) {
    _verifyValidStateHash();
    _send(action);
  }

  void _send(Action action, {bool fromChild = false}) {
    _state._isMutationAllowed = true;
    final effect = _reducer(_state, action);
    _currentStateHash = state.hashCode;
    _state._isMutationAllowed = false;
    syncStream.add(StateUpdate(_state._value, fromChild));

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];

    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }

  void _verifyValidStateHash() {
    if (_currentStateHash != state.hashCode) {
      throw EffectfullStateMutation();
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
      store._currentStateHash = store.state.hashCode;
      if (!update.fromChild) {
        store.syncStream.add(StateUpdate(state.get(update.state), false));
      }
    });

    return store;
  }
}
