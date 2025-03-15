import 'package:composable_architecture/composable_architecture.dart';

part '_helper_shared_state.freezed.dart';
part '_helper_shared_state.g.dart';

@freezed
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

final sharedReducer = combine([
  pullback(
    sharedCounterReducer,
    state: SharedStatePath.counterA,
    action: SharedActionPath.counterA,
  ),
  pullback(
    sharedCounterReducer,
    state: SharedStatePath.counterB,
    action: SharedActionPath.counterB,
  ),
  (Inout<SharedState> state, SharedAction action) {
    switch (action) {
      case SharedActionNonSharedCounterIncrement():
        state.mutate((s) => s.copyWith(nonSharedCounter: s.nonSharedCounter + 1));
        return Effect.none<SharedAction>();
      default:
        return Effect.none<SharedAction>();
    }
  }
]);

@freezed
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

Effect<SharedCounterAction> sharedCounterReducer(
    Inout<SharedCounterState> state, SharedCounterAction action) {
  switch (action) {
    case SharedCounterActionIncrement():
      state.mutate((s) => s.copyWith(count: s.count.set((c) => c + 1)));
      return Effect.none();
  }
}
