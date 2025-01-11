import 'reducer.dart';

final class Store<State, Action> {
  final Reducer<State, Action> _reducer;
  final State _state;
  State get state => _state;

  Store({
    required State initialState,
    required Reducer<State, Action> reducer,
  })  : _state = initialState,
        _reducer = reducer;

  void send(Action action) {
    final effect = _reducer(_state, action);
    effect.run(send);
  }
}
