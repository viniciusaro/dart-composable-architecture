part of 'store.dart';

typedef Reducer<State extends Equatable, Action> = Effect<State, Action> Function(State, Action);

Reducer<State, Action> debug<State extends Equatable, Action>(
  Reducer<State, Action> other,
) {
  return (state, action) {
    final effect = other(state, action);

    return Effect._(
      id: effect.id,
      cancellationId: effect.cancellationId,
      mutation: (state) {
        print("--------");
        print("received action: $action");
        final updated = effect.mutation?.call(state) ?? state;
        if (state == updated) {
          print("state: no changes detected");
        } else {
          print("state: $updated");
        }
        return updated;
      },
      builder: effect.builder,
    );
  };
}
