part of 'store.dart';

final class Inout<T> {
  T _value;
  bool _isMutationAllowed = false;
  Inout({required T value}) : _value = value;

  void mutate(T Function(T) mutation) {
    if (_isMutationAllowed) {
      _value = mutation(_value);
    } else {
      throw EffectfullStateMutation();
    }
  }
}

typedef Reducer<State, Action> = Effect<Action> Function(Inout<State>, Action);

Reducer<State, Action> debug<State, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final previous = state._value;
    final effect = other(state, action);
    final updated = state._value;
    final msgUpdate = previous == updated ? "state: no changes detected" : "state: $updated";

    return Effect(() {
      print(msgHeader);
      print(msgAction);
      print(msgUpdate);
      return effect.builder();
    });
  };
}

Reducer<State, Action> combine<State, Action>(List<Reducer<State, Action>> reducers) {
  return (state, action) {
    return Effect.merge(
      reducers.map((reducer) => reducer(state, action)).toList(),
    );
  };
}
