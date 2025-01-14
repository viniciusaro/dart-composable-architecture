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

Effect<CounterState, CounterAction> counterReducer(
  CounterState state,
  CounterAction action,
) {
  switch (action) {
    case CounterAction.cancelIncrementRepeatedly:
      return Effect.cancel(id: CounterTimerId.id);
    case CounterAction.increment:
      return Effect.sync(
        (state) => state.copyWith(count: state.count + 1),
      );
    case CounterAction.incrementRepeatedly:
      return Effect.stream(
        id: CounterTimerId.id,
        run: () async* {
          while (true) {
            await Future.delayed(Duration(seconds: 1));
            yield CounterAction.increment;
          }
        },
      );
    case CounterAction.incrementWithDelay:
      return Effect.future(run: () async {
        await Future.delayed(Duration(seconds: 1));
        return CounterAction.increment;
      });
  }
}
