import 'dart:async';

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
    _state = effect.mutation?.call(state) ?? _state;

    final cancellationId = effect.cancellationId?.hashCode;
    if (cancellationId != null) {
      _subscriptions[cancellationId]?.cancel();
      _subscriptions.remove(cancellationId);
    }

    final subscription = effect.builder().listen(send);

    final id = effect.id?.hashCode;
    if (id != null) {
      _subscriptions[id] = subscription;
    }
  }
}
