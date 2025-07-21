import 'package:composable_architecture/composable_architecture.dart';

part '_helper_shared_state.g.dart';

@KeyPathable()
class SharedState with _$SharedState {
  @override
  final SharedCounterState counterA;

  @override
  final SharedCounterState counterB;

  @override
  final int nonSharedCounter;

  SharedState({
    SharedCounterState? counterA,
    SharedCounterState? counterB,
    this.nonSharedCounter = 0,
  })  : counterA = counterA ?? SharedCounterState(),
        counterB = counterB ?? SharedCounterState();
}

@CaseKeyPathable()
sealed class SharedAction<
    CounterA extends SharedCounterAction,
    CounterB extends SharedCounterAction,
    NonSharedCounterIncrement //
    > {}

final class SharedFeature extends Feature<SharedState, SharedAction> {
  @override
  Reducer<SharedState, SharedAction> build() {
    return Reduce.combine([
      Scope(
        state: SharedStatePath.counterA,
        action: SharedActionPath.counterA,
        reducer: SharedCounterFeature(),
      ),
      Scope(
        state: SharedStatePath.counterB,
        action: SharedActionPath.counterB,
        reducer: SharedCounterFeature(),
      ),
      Reduce((state, action) {
        switch (action) {
          case SharedActionNonSharedCounterIncrement():
            state.mutate(
              (s) => s.copyWith(nonSharedCounter: s.nonSharedCounter + 1),
            );
            return Effect.none<SharedAction>();
          default:
            return Effect.none<SharedAction>();
        }
      }),
    ]);
  }
}

@KeyPathable()
class SharedCounterState with _$SharedCounterState {
  @override
  final Shared<int> count;

  SharedCounterState({Shared<int>? count}) //
      : count = count ?? Shared<int>(InMemorySource(0));
}

@CaseKeyPathable()
sealed class SharedCounterAction<
    Increment //
    > {}

final class SharedCounterFeature
    extends Feature<SharedCounterState, SharedCounterAction> {
  @override
  Reducer<SharedCounterState, SharedCounterAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case SharedCounterActionIncrement():
          state.mutate((s) => s.copyWith(count: s.count.set((c) => c + 1)));
          return Effect.none();
      }
    });
  }
}
