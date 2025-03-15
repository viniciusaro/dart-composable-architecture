import 'package:composable_architecture/composable_architecture.dart';

part '_helper_root_state.freezed.dart';
part '_helper_root_state.g.dart';

@freezed
@KeyPathable()
class RootState with _$RootState {
  @override
  final CounterState counter;

  @override
  final FavoritesState favorites;

  RootState({CounterState? counter, FavoritesState? favorites})
      : counter = counter ?? CounterState(),
        favorites = favorites ?? FavoritesState();
}

@CaseKeyPathable()
sealed class RootAction<
    Counter extends CounterAction,
    Favorites extends FavoritesAction //
    > {}

@freezed
@KeyPathable()
final class CounterState with _$CounterState {
  @override
  final int count;
  CounterState({this.count = 0});
}

@CaseKeyPathable()
sealed class CounterAction<
    Increment,
    Decrement //
    > {}

@freezed
@KeyPathable()
final class FavoritesState with _$FavoritesState {
  @override
  final List<int> favorites;
  FavoritesState({this.favorites = const []});
}

@CaseKeyPathable()
sealed class FavoritesAction<
    Add extends int,
    RemoveAt extends int //
    > {}

final rootReducer = combine([
  pullback(counterReducer, state: RootStatePath.counter, action: RootActionPath.counter),
  pullback(favoritesReducer, state: RootStatePath.favorites, action: RootActionPath.favorites),
]);

Effect<CounterAction> counterReducer(
  Inout<CounterState> state,
  CounterAction action,
) {
  switch (action) {
    case CounterActionIncrement():
      state.mutate((s) => s.copyWith(count: s.count + 1));
      return Effect.none();
    case CounterActionDecrement():
      state.mutate((s) => s.copyWith(count: s.count - 1));
      return Effect.none();
  }
}

Effect<FavoritesAction> favoritesReducer(
  Inout<FavoritesState> state,
  FavoritesAction action,
) {
  switch (action) {
    case FavoritesActionAdd():
      state.mutate((s) => s.copyWith(favorites: [...s.favorites, action.add]));
      return Effect.none();
    case FavoritesActionRemoveAt():
      state.mutate((s) => s..favorites.removeAt(action.removeAt));
      return Effect.none();
  }
}
