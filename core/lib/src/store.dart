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
    final id = effect.id?.hashCode;
    _state = effect.mutation?.call(state) ?? _state;

    final subscription = effect.builder().listen((action) {
      switch (action) {
        case Cancel<Action>():
          final id = effect.id?.hashCode;
          if (id != null) {
            _subscriptions[id]?.cancel();
            _subscriptions.remove(id);
          }
        case Forward<Action>():
          send(action.action);
      }
    });

    if (id != null) {
      _subscriptions[id] = subscription;
    }
  }
}
