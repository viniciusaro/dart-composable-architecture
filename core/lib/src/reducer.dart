part of 'store.dart';

final class Inout<T extends Equatable> {
  T _value;
  T get value => _value;
  Inout({required T value}) : _value = value;

  void mutate(T Function(T) mutation) {
    _value = mutation(_value);
  }
}

typedef Reducer<State extends Equatable, Action> = Effect<Action> Function(Inout<State>, Action);

Reducer<State, Action> debug<State extends Equatable, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final previous = state.value;
    final effect = other(state, action);
    final updated = state.value;
    final msgUpdate = previous == updated ? "state: no changes detected" : "state: $updated";

    return Effect(() {
      print(msgHeader);
      print(msgAction);
      print(msgUpdate);
      return effect.builder();
    });
  };
}
