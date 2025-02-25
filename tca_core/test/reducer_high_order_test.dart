import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

part 'reducer_high_order_test.g.dart';

@KeyPathable()
class RootState {
  CounterState counter = CounterState();
  FavoritesState favorites = FavoritesState();
}

@CaseKeyPathable()
sealed class RootAction<
    Counter extends CounterAction,
    Favorites extends FavoritesAction //
    > {}

@KeyPathable()
final class CounterState {
  int count = 0;
}

@CaseKeyPathable()
sealed class CounterAction<
    Increment,
    Decrement //
    > {}

@KeyPathable()
class FavoritesState {
  List<int> favorites = [];
}

@CaseKeyPathable()
sealed class FavoritesAction<
    Add extends FavoritesAdd,
    RemoveAt extends FavoritesRemoveAt //
    > {}

class FavoritesAdd {
  final int favorite;
  FavoritesAdd(this.favorite);
}

class FavoritesRemoveAt {
  final int index;
  FavoritesRemoveAt(this.index);
}

Effect<CounterAction> counterReducer(
  Inout<CounterState> state,
  CounterAction action,
) {
  switch (action) {
    case CounterActionIncrement():
      state.mutate((s) => s..count += 1);
      return Effect.none();
    case CounterActionDecrement():
      state.mutate((s) => s..count -= 1);
      return Effect.none();
  }
}

Effect<FavoritesAction> favoritesReducer(
  Inout<FavoritesState> state,
  FavoritesAction action,
) {
  switch (action) {
    case FavoritesActionAdd():
      state.mutate((s) => s..favorites.add(action.add.favorite));
      return Effect.none();
    case FavoritesActionRemoveAt():
      state.mutate((s) => s..favorites.removeAt(action.removeAt.index));
      return Effect.none();
  }
}

Effect<FavoritesAction> favoritesAnalyticsReducer(
  Inout<FavoritesState> state,
  FavoritesAction action,
) {
  switch (action) {
    case FavoritesActionAdd():
      return Effect.sync(() => analytics.add("add ${action.add.favorite}"));
    case FavoritesActionRemoveAt():
      return Effect.sync(() => analytics.add("remove at ${action.removeAt.index}"));
  }
}

var analytics = <String>[];

void main() {
  setUp(() {
    analytics = [];
  });

  group('reducer', () {
    test('pullback transforms local reducer into global one', () {
      final Reducer<RootState, RootAction> reducer = pullback(
        favoritesReducer,
        state: RootStatePath.favorites,
        action: RootActionPath.favorites,
      );

      final store = Store(initialState: RootState(), reducer: reducer);

      store.send(RootActionEnum.favorites(FavoritesActionEnum.add(FavoritesAdd(1))));
      expect(store.state.favorites.favorites, [1]);

      store.send(RootActionEnum.favorites(FavoritesActionEnum.removeAt(FavoritesRemoveAt(0))));
      expect(store.state.favorites.favorites, []);
    });

    test('combine runs all reducers in list', () {
      final reducer = combine([
        favoritesReducer,
        favoritesAnalyticsReducer,
      ]);

      final store = Store(initialState: FavoritesState(), reducer: reducer);

      store.send(FavoritesActionEnum.add(FavoritesAdd(1)));
      expect(store.state.favorites, [1]);

      store.send(FavoritesActionEnum.removeAt(FavoritesRemoveAt(0)));
      expect(store.state.favorites, []);

      expect(analytics, ["add 1", "remove at 0"]);
    });

    test('pullback and combine works together', () {
      final Reducer<RootState, RootAction> reducer = combine([
        pullback(
          counterReducer,
          state: RootStatePath.counter,
          action: RootActionPath.counter,
        ),
        pullback(
          favoritesReducer,
          state: RootStatePath.favorites,
          action: RootActionPath.favorites,
        ),
      ]);

      final store = Store(initialState: RootState(), reducer: reducer);

      store.send(RootActionEnum.counter(CounterActionEnum.increment()));
      expect(store.state.counter.count, 1);

      store.send(RootActionEnum.favorites(FavoritesActionEnum.add(FavoritesAdd(1))));
      expect(store.state.favorites.favorites, [1]);
    });
  });
}
