import 'dart:async';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';

part 'effect.dart';
part 'reducer.dart';

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
    final result = _reducer(_state, action);
    _state = result.mutation(state);

    final cancellationId = result.effect.cancellationId?.hashCode;
    if (cancellationId != null) {
      _subscriptions[cancellationId]?.cancel();
      _subscriptions.remove(cancellationId);
    }

    final subscription = result.effect.builder().listen(send);

    final id = result.effect.id?.hashCode;
    if (id != null) {
      _subscriptions[id] = subscription;
    }
  }
}
