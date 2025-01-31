import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:key_path/key_path.dart';

part '_exceptions.dart';
part 'effect.dart';
part 'reducer.dart';

final class Store<State, Action> {
  final Reducer<State, Action> _reducer;
  final Inout<State> _state;
  State get state => _state._value;
  final StreamController<State> _stateController = StreamController.broadcast();
  Stream<State> get stream => _stateController.stream;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = Inout(value: initialState),
        _reducer = reducer;

  void send(Action action) {
    _state._isMutationAllowed = true;
    final effect = _reducer(_state, action);
    _state._isMutationAllowed = false;
    _stateController.add(_state._value);

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];
    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }
}
