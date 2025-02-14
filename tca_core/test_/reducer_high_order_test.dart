import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

@KeyPathable()
class RootState {
  CounterState counter = CounterState();
  FavoritesState favorites = FavoritesState();
}

@CaseKeyPathable()
final class RootAction<Counter extends CounterAction, Favorites extends FavoritesAction> {}

@KeyPathable()
final class CounterState {
  int count = 0;
}

@CaseKeyPathable()
final class CounterAction<Increment, Decrement> {}

@KeyPathable()
class FavoritesState {
  List<int> favorites = [];
}

@CaseKeyPathable()
final class FavoritesAction<Add extends FavoritesAdd, RemoveAt extends FavoritesRemoveAt> {}

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
  throw Exception("invalid action");
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
  throw Exception("invalid action");
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
  throw Exception("invalid action");
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
        state: RootState.favoritesPath,
        action: RootAction.favoritesPath,
      );

      final store = Store(initialState: RootState(), reducer: reducer);

      store.send(RootAction.favorites(FavoritesAction.add(FavoritesAdd(1))));
      expect(store.state.favorites.favorites, [1]);

      store.send(RootAction.favorites(FavoritesAction.removeAt(FavoritesRemoveAt(0))));
      expect(store.state.favorites.favorites, []);
    });

    test('combine runs all reducers in list', () {
      final reducer = combine([
        favoritesReducer,
        favoritesAnalyticsReducer,
      ]);

      final store = Store(initialState: FavoritesState(), reducer: reducer);

      store.send(FavoritesAction.add(FavoritesAdd(1)));
      expect(store.state.favorites, [1]);

      store.send(FavoritesAction.removeAt(FavoritesRemoveAt(0)));
      expect(store.state.favorites, []);

      expect(analytics, ["add 1", "remove at 0"]);
    });

    test('pullback and combine works together', () {
      final Reducer<RootState, RootAction> reducer = combine([
        pullback(
          counterReducer,
          state: RootState.counterPath,
          action: RootAction.counterPath,
        ),
        pullback(
          favoritesReducer,
          state: RootState.favoritesPath,
          action: RootAction.favoritesPath,
        ),
      ]);

      final store = Store(initialState: RootState(), reducer: reducer);

      store.send(RootAction.counter(CounterAction.increment()));
      expect(store.state.counter.count, 1);

      store.send(RootAction.favorites(FavoritesAction.add(FavoritesAdd(1))));
      expect(store.state.favorites.favorites, [1]);
    });
  });
}
