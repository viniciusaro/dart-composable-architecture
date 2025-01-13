import 'package:core/core.dart';

final class CounterState {
  int count = 0;

  @override
  String toString() {
    return "AppState: count: $count";
  }
}

enum CounterAction {
  cancelIncrementRepeatedly,
  increment,
  incrementRepeatedly,
  incrementWithDelay,
}

enum CounterTimerId { id }

Effect<CounterAction> counterReducer(CounterState state, CounterAction action) {
  switch (action) {
    case CounterAction.cancelIncrementRepeatedly:
      return Effect.cancel(CounterTimerId.id);
    case CounterAction.increment:
      state.count += 1;
      return Effect.none();
    case CounterAction.incrementRepeatedly:
      return Effect.stream(CounterTimerId.id, () async* {
        while (true) {
          await Future.delayed(Duration(seconds: 1));
          yield CounterAction.increment;
        }
      });
    case CounterAction.incrementWithDelay:
      return Effect.future(() async {
        await Future.delayed(Duration(seconds: 1));
        return CounterAction.increment;
      });
  }
}
