import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/feature_composition/counter.dart';
import 'package:tca_flutter_example/feature_composition/favorites.dart';
import 'package:tca_flutter_example/feature_composition/feature_composition.dart';

void main() {
  group('counter', () {
    test("add to favorites button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(
        AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()),
        AppState(counter: CounterState(favorites: {0}), favorites: FavoritesState(favorites: {0})),
      );
    });

    test("decrement button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(
        AppActionEnum.counter(CounterActionEnum.decrementButtonTapped()),
        AppState(counter: CounterState(count: -1)),
      );
    });

    test("increment button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(
        AppActionEnum.counter(CounterActionEnum.incrementButtonTapped()),
        AppState(counter: CounterState(count: 1)),
      );
    });

    test("remove from favorites button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: appReducer);

      store.send(
        AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()),
        AppState(counter: CounterState(favorites: {0}), favorites: FavoritesState(favorites: {0})),
      );

      store.send(
        AppActionEnum.counter(CounterActionEnum.removeFromFavoritesButtonTapped()),
        AppState(counter: CounterState(favorites: {}), favorites: FavoritesState(favorites: {})),
      );
    });
  });

  group("favorite", () {
    test("remove from favorites favorites button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: appReducer);

      store.send(
        AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()),
        AppState(counter: CounterState(favorites: {0}), favorites: FavoritesState(favorites: {0})),
      );

      store.send(
        AppActionEnum.favorites(FavoritesActionEnum.remove(0)),
        AppState(counter: CounterState(favorites: {}), favorites: FavoritesState(favorites: {})),
      );
    });
  });
}
