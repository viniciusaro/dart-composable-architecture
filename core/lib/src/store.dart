import 'dart:async';

import 'package:equatable/equatable.dart';

part 'effect.dart';
part 'reducer.dart';

final class Store<State extends Equatable, Action> {
  final Reducer<State, Action> _reducer;
  State _state;
  State get state => _state;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = initialState,
        _reducer = reducer;

  void send(Action action) {
    final result = _reducer(_state, action);
    final effect = result.effect;
    _state = result.mutation(state);

    final stream = effect.builder();
    final id = _cancellableEffects[effect._cancellableId];
    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }
}
