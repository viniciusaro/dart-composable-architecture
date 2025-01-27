import 'dart:async';

import 'package:equatable/equatable.dart';

part 'effect.dart';
part 'reducer.dart';
part 'store_exceptions.dart';

final class Store<State extends Equatable, Action> {
  final Reducer<State, Action> _reducer;
  final Inout<State> _state;
  State get state => _state.value;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = Inout(value: initialState),
        _reducer = reducer;

  void send(Action action) {
    final effect = _reducer(_state, action);

    final beforeEffect = _state.value.hashCode;
    final stream = effect.builder();
    final afterEffect = _state.value.hashCode;

    if (afterEffect != beforeEffect) {
      throw EffectfullStateMutation();
    }

    final id = _cancellableEffects[effect._cancellableId];
    final subscription = stream.listen(send);

    if (id != null) {
      _effectSubscriptions[id] = subscription;
    }
  }
}
