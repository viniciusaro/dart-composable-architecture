part of 'store.dart';

typedef Mutation<State> = State Function(State);

final class ReducerResult<State, Action> {
  final Mutation<State> mutation;
  final Effect<Action> effect;

  static T _identity<T>(T state) => state;

  ReducerResult({
    Mutation<State>? mutation,
    Effect<Action>? effect,
  })  : mutation = mutation ?? _identity,
        effect = effect ?? Effect.none();
}

typedef Reducer<State extends Equatable, Action> = ReducerResult<State, Action> Function(
    State, Action);

Reducer<State, Action> debug<State extends Equatable, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final result = other(state, action);

    return ReducerResult(
      mutation: (state) {
        print("--------");
        print("received action: $action");
        final updated = result.mutation(state);
        if (state == updated) {
          print("state: no changes detected");
        } else {
          print("state: $updated");
        }
        return updated;
      },
      effect: result.effect,
    );
  };
}
