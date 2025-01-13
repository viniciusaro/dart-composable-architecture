import 'dart:async';

import 'package:core/src/effect.dart';

import 'reducer.dart';

final class Store<State, Action> {
  final Reducer<State, Action> _reducer;
  final State _state;
  State get state => _state;
  final Map<int, StreamSubscription> _subscriptions = {};

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = initialState,
        _reducer = reducer;

  void send(Action action) {
    final effect = _reducer(_state, action);
    switch (effect) {
      case CancelEffect<Action>():
        _subscriptions[effect.id.hashCode]?.cancel();
        _subscriptions.remove(effect.id.hashCode);
      case FutureEffect<Action>():
        final result = effect.run();
        if (result is Future<Action>) {
          result.then(send);
        } else {
          send(result);
        }
      case StreamEffect<Action>():
        _subscriptions[effect.id.hashCode] = effect.run().listen(send);
      case RunEffect<Action>():
        effect.run(send);
    }
  }
}
