part of 'counter_example.dart';

final class InvalidCounterState {
  int count = 0;
}

Effect<CounterAction> invalidCounterReducer(
  Inout<InvalidCounterState> state,
  CounterAction action,
) {
  switch (action) {
    case CounterAction.increment:
      state.mutate((s) => s..count += 1);
      return Effect.none();
    default:
      return Effect.none();
  }
}
