import 'package:composable_architecture/composable_architecture.dart';

final class CounterState {
  final int count;

  CounterState({this.count = 0});

  CounterState copyWith({required int count}) {
    return CounterState(count: count);
  }

  @override
  int get hashCode => count.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is CounterState && other.count == count;
  }
}

enum CounterAction {
  increment,
  incrementRepeatedly,
  incrementWithDelay,
  cancelIncrementRepeatedly,
}

enum CounterTimerId { id }

Effect<CounterAction> counterReducer(
    Inout<CounterState> state, CounterAction action) {
  switch (action) {
    case CounterAction.increment:
      state.mutate((s) => s.copyWith(count: s.count + 1));
      return Effect.none();
    case CounterAction.incrementRepeatedly:
      return Effect.stream(
        () async* {
          while (true) {
            await Future.delayed(Duration(seconds: 1));
            yield CounterAction.increment;
          }
        },
      ).cancellable(CounterTimerId.id);
    case CounterAction.incrementWithDelay:
      return Effect.stream(
        () =>
            Future.delayed(Duration(seconds: 1), () => CounterAction.increment)
                .asStream(),
      );
    case CounterAction.cancelIncrementRepeatedly:
      return Effect.cancel(CounterTimerId.id);
  }
}

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
