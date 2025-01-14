import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

final class CounterState extends Equatable {
  final int count;

  CounterState({this.count = 0});

  @override
  List<Object?> get props => [count];

  CounterState copyWith({required int count}) {
    return CounterState(count: count);
  }
}

enum CounterAction {
  cancelIncrementRepeatedly,
  increment,
  incrementRepeatedly,
  incrementWithDelay,
}

enum CounterTimerId { id }

Mutation<CounterState, CounterAction> counterReducer(
  CounterState state,
  CounterAction action,
) {
  switch (action) {
    case CounterAction.cancelIncrementRepeatedly:
      return Mutation.none(
        Effect.cancel(CounterTimerId.id),
      );
    case CounterAction.increment:
      return Mutation.mutate(
        (state) => state.copyWith(count: state.count + 1),
        Effect.none(),
      );
    case CounterAction.incrementRepeatedly:
      return Mutation.none(
        Effect.stream(CounterTimerId.id, () async* {
          while (true) {
            await Future.delayed(Duration(seconds: 1));
            yield CounterAction.increment;
          }
        }),
      );
    case CounterAction.incrementWithDelay:
      return Mutation.none(
        Effect.future(() async {
          await Future.delayed(Duration(seconds: 1));
          return CounterAction.increment;
        }),
      );
  }
}
