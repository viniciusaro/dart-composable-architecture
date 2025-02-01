import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:key_path/key_path.dart';

part '_exceptions.dart';
part '_syncStream.dart';
part 'effect.dart';
part 'reducer.dart';

final class Store<State, Action> {
  final Reducer<State, Action> _reducer;
  final Inout<State> _state;
  State get state => _state._value;
  final syncStream = SyncStream<State>();
  void Function()? _onClose;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = Inout(value: initialState),
        _reducer = reducer;

  Store._({
    required State initialState,
    required Reducer<State, Action> reducer,
    void Function()? onClose,
  })  : _state = Inout(value: initialState),
        _reducer = reducer,
        _onClose = onClose;

  void send(Action action) {
    _state._isMutationAllowed = true;
    final effect = _reducer(_state, action);
    _state._isMutationAllowed = false;
    syncStream._add(_state._value);

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
    late Store<LocalState, LocalAction> store;

    final subscription = syncStream.listen((update) {
      store._state._value = state.get(update);
    });

    store = Store<LocalState, LocalAction>._(
      initialState: state.get(this.state),
      reducer: (localState, localAction) {
        final globalAction = action.set(null, localAction);
        if (globalAction != null) {
          send(globalAction);
        }
        return Effect.none();
      },
      onClose: () => subscription.cancel(),
    );

    return store;
  }

  void close() {
    _onClose?.call();
  }
}
