import 'dart:async';

import 'package:core/src/effect.dart';
import 'package:equatable/equatable.dart';

import 'reducer.dart';

final class Store<State extends Equatable, Action> {
  final Reducer<State, Action> _reducer;
  State _state;
  State get state => _state;

  final Map<int, StreamSubscription> _subscriptions = {};

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = initialState,
        _reducer = reducer;

  void send(Action action) {
    final effect = _reducer(_state, action);
    _state = effect.mutation?.call(_state) ?? _state;

    switch (effect) {
      case CancelEffect():
        _subscriptions[effect.id.hashCode]?.cancel();
        _subscriptions.remove(effect.id.hashCode);
      case FutureEffect():
        final result = effect.run();
        result.then(send);
      case StreamEffect():
        final stream = effect.run();
        _subscriptions[effect.id.hashCode] = stream.listen(send);
      case RunEffect():
        effect.run(send);
    }
  }
}
