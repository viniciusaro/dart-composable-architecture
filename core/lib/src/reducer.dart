import 'package:equatable/equatable.dart';

import 'effect.dart';

typedef Reducer<State extends Equatable, Action> = Effect<State, Action>
    Function(State, Action);

Reducer<State, Action> debug<State extends Equatable, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final effect = other(state, action);

    State mutateAndPrint(State state) {
      print("--------");
      print("received action: $action");
      final updated = effect.mutation?.call(state) ?? state;
      print("state: $updated");
      return updated;
    }

    switch (effect) {
      case CancelEffect():
        return Effect.cancel(
          mutation: mutateAndPrint,
          id: effect.id,
        );
      case FutureEffect():
        return Effect.future(
          mutation: mutateAndPrint,
          run: effect.run,
        );
      case RunEffect():
        return Effect.run(
          mutation: mutateAndPrint,
          run: effect.run,
        );
      case StreamEffect():
        return Effect.stream(
          mutation: mutateAndPrint,
          id: effect.id,
          run: effect.run,
        );
    }
  };
}
