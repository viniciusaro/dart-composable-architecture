import 'package:core/core.dart';

final class CounterState extends Equatable {
  final int count;

  CounterState({this.count = 0});

  CounterState copyWith({required int count}) {
    return CounterState(count: count);
  }

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

Effect<CounterAction> counterReducer(Inout<CounterState> state, CounterAction action) {
  switch (action) {
    case CounterAction.increment:
      state.mutate((s) => s.copyWith(count: s.count + 1));
      return Effect.none();
    case CounterAction.incrementRepeatedly:
      return Effect.stream<CounterAction>(
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
