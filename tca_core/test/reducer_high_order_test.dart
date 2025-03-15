import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper_root_state.dart';

Effect<FavoritesAction> favoritesAnalyticsReducer(
  Inout<FavoritesState> state,
  FavoritesAction action,
) {
  switch (action) {
    case FavoritesActionAdd():
      return Effect.sync(() => analytics.add("add ${action.add}"));
    case FavoritesActionRemoveAt():
      return Effect.sync(() => analytics.add("remove at ${action.removeAt}"));
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

      store.send(RootActionEnum.favorites(FavoritesActionEnum.add(1)));
      expect(store.state.favorites.favorites, [1]);

      store.send(RootActionEnum.favorites(FavoritesActionEnum.removeAt(0)));
      expect(store.state.favorites.favorites, []);
    });

    test('combine runs all reducers in list', () {
      final reducer = combine([
        favoritesReducer,
        favoritesAnalyticsReducer,
      ]);

      final store = Store(initialState: FavoritesState(), reducer: reducer);

      store.send(FavoritesActionEnum.add(1));
      expect(store.state.favorites, [1]);

      store.send(FavoritesActionEnum.removeAt(0));
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

      store.send(RootActionEnum.favorites(FavoritesActionEnum.add(1)));
      expect(store.state.favorites.favorites, [1]);
    });
  });
}
