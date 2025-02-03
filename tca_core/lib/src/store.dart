import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:key_path/key_path.dart';

part '_exceptions.dart';
part '_syncStream.dart';
part 'effect.dart';
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
    syncStream._add(StateUpdate(_state._value, fromChild));

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
        store.syncStream._add(StateUpdate(state.get(update.state), false));
      }
    });

    return store;
  }
}
