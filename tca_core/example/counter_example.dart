import 'package:composable_architecture/composable_architecture.dart';

final class CounterState extends Equatable {
  int count = 0;

  @override
  List<Object?> get props => [count];
}

enum CounterAction {
  increment,
  incrementRepeatedly,
  incrementWithDelay,
  cancelIncrementRepeatedly,
}

enum CounterTimerId { id }

Effect<CounterAction> counterReducer(CounterState state, CounterAction action) {
  switch (action) {
    case CounterAction.increment:
      state.count += 1;
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
        () => Future.delayed(Duration(seconds: 1), () => CounterAction.increment).asStream(),
      );
    case CounterAction.cancelIncrementRepeatedly:
      return Effect.cancel(CounterTimerId.id);
  }
}
