import 'package:equatable/equatable.dart';

import 'effect.dart';

typedef Reducer<State extends Equatable, Action> = Mutation<State, Action>
    Function(State, Action);

Reducer<State, Action> debug<State extends Equatable, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final msgHeader = "--------";
    final msgAction = "received action: $action";
    final mutation = other(state, action);
    final effect = mutation.effect;
    final msgState = "state: $state";

    switch (effect) {
      case CancelEffect():
        print(msgHeader);
        print(msgAction);
        print(msgState);
        return Mutation.mutate(
          mutation.update,
          Effect.cancel(effect.id),
        );
      case FutureEffect():
        return Mutation.mutate(
          mutation.update,
          FutureEffect(() {
            print(msgHeader);
            print(msgAction);
            print(msgState);
            return effect.run();
          }),
        );
      case RunEffect<Action>():
        return Mutation.mutate(
          mutation.update,
          Effect.run((send) {
            print(msgHeader);
            print(msgAction);
            print(msgState);
            effect.run(send);
          }),
        );
      case StreamEffect<Action>():
        return Mutation.mutate(
          mutation.update,
          Effect.stream(effect.id, () {
            print(msgHeader);
            print(msgAction);
            print(msgState);
            return effect.run();
          }),
        );
    }
  };
}

final class Mutation<State extends Equatable, Action> {
  final State Function(State) update;
  final Effect<Action> effect;
  Mutation._(this.update, this.effect);

  static Mutation<State, Action> mutate<State extends Equatable, Action>(
    State Function(State) mutate,
    Effect<Action> effect,
  ) {
    return Mutation._(mutate, effect);
  }

  static Mutation<State, Action> none<State extends Equatable, Action>(
    Effect<Action> effect,
  ) {
    return Mutation._((state) => state, effect);
  }
}
