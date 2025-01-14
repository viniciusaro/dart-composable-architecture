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
  increment,
  incrementRepeatedly,
  incrementWithDelay,
  cancelIncrementRepeatedly,
}

enum CounterTimerId { id }

ReducerResult<CounterState, CounterAction> counterReducer(
  CounterState state,
  CounterAction action,
) {
  switch (action) {
    case CounterAction.increment:
      return ReducerResult(
        mutation: (state) => state.copyWith(count: state.count + 1),
      );
    case CounterAction.incrementRepeatedly:
      return ReducerResult(
        effect: Effect.stream(
          CounterTimerId.id,
          () async* {
            while (true) {
              await Future.delayed(Duration(seconds: 1));
              yield CounterAction.increment;
            }
          },
        ),
      );
    case CounterAction.incrementWithDelay:
      return ReducerResult(
        effect: Effect.future(() async {
          await Future.delayed(Duration(seconds: 1));
          return CounterAction.increment;
        }),
      );
    case CounterAction.cancelIncrementRepeatedly:
      return ReducerResult(
        effect: Effect.cancel(CounterTimerId.id),
      );
  }
}
