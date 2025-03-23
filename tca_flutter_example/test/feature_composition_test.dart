import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/feature_composition/counter.dart';
import 'package:tca_flutter_example/feature_composition/favorites.dart';
import 'package:tca_flutter_example/feature_composition/feature_composition.dart';

void main() {
  tearDown(() {
    InMemorySource<Set<int>>({}).set({});
  });

  group('counter', () {
    test("add to favorites button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: AppFeature());
      store.send(
        AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()),
        (_) => AppState(
          counter: CounterState(favorites: Shared.constant({0})),
          favorites: FavoritesState(favorites: Shared.constant({0})),
        ),
      );
    });

    test("decrement button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: AppFeature());
      store.send(
        AppActionEnum.counter(CounterActionEnum.decrementButtonTapped()),
        (_) => AppState(counter: CounterState(count: -1)),
      );
    });

    test("increment button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: AppFeature());
      store.send(
        AppActionEnum.counter(CounterActionEnum.incrementButtonTapped()),
        (_) => AppState(counter: CounterState(count: 1)),
      );
    });

    test("remove from favorites button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: AppFeature());

      store.send(
        AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()),
        (_) => AppState(
          counter: CounterState(favorites: Shared.constant({0})),
          favorites: FavoritesState(favorites: Shared.constant({0})),
        ),
      );

      store.send(
        AppActionEnum.counter(
          CounterActionEnum.removeFromFavoritesButtonTapped(),
        ),
        (_) => AppState(
          counter: CounterState(favorites: Shared.constant({})),
          favorites: FavoritesState(favorites: Shared.constant({})),
        ),
      );
    });
  });

  group("favorite", () {
    test("remove from favorites favorites button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: AppFeature());

      store.send(
        AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()),
        (_) => AppState(
          counter: CounterState(favorites: Shared.constant({0})),
          favorites: FavoritesState(favorites: Shared.constant({0})),
        ),
      );

      store.send(
        AppActionEnum.favorites(FavoritesActionEnum.remove(0)),
        (_) => AppState(
          counter: CounterState(favorites: Shared.constant({})),
          favorites: FavoritesState(favorites: Shared.constant({})),
        ),
      );
    });
  });
}
