import 'effect.dart';

typedef Reducer<State, Action> = Effect<Action> Function(State, Action);

Reducer<State, Action> debug<State, Action>(Reducer<State, Action> other) {
  return (state, action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final effect = other(state, action);
    final msgState = "state: $state";

    switch (effect) {
      case CancelEffect():
        print(msgHeader);
        print(msgAction);
        print(msgState);
        return Effect.cancel(effect.id);
      case FutureEffect():
        return FutureEffect(() {
          print(msgHeader);
          print(msgAction);
          print(msgState);
          return effect.run();
        });
      case RunEffect<Action>():
        return Effect.run((send) {
          print(msgHeader);
          print(msgAction);
          print(msgState);
          effect.run(send);
        });
      case StreamEffect<Action>():
        return Effect.stream(effect.id, () {
          print(msgHeader);
          print(msgAction);
          print(msgState);
          return effect.run();
        });
    }
  };
}
