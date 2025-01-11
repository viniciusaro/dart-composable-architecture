import 'effect.dart';

typedef Reducer<State, Action> = Effect<Action> Function(State, Action);

Reducer<State, Action> debug<State, Action>(Reducer<State, Action> other) {
  return (state, action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final effect = other(state, action);
    final msgState = "state: $state";

    return Effect((send) {
      print(msgHeader);
      print(msgAction);
      print(msgState);
      effect.run(send);
    });
  };
}
