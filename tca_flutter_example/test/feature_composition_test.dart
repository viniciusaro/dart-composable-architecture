import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/feature_composition/feature_composition.dart';

void main() {
  group('counter', () {
    test("add to favorites button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      final action = AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped());
      await store.send(action, (state) {
        return state
          ..counter.favorites = {0}
          ..favorites.favorites = {0};
      });
    });

    test("decrement button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      await store.send(
        AppActionEnum.counter(CounterActionEnum.decrementButtonTapped()),
        (state) => state..counter.count = -1,
      );
    });

    test("increment button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(
        AppActionEnum.counter(CounterActionEnum.incrementButtonTapped()),
        (state) => state..counter.count = 1,
      );
    });

    test("remove from favorites button tapped", () async {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      final addAction = AppActionEnum.counter(
        CounterActionEnum.addToFavoritesButtonTapped(), //
      );
      final removeAction = AppActionEnum.counter(
        CounterActionEnum.removeFromFavoritesButtonTapped(),
      );

      await store.send(addAction, (state) {
        return state
          ..counter.favorites = {0}
          ..favorites.favorites = {0};
      });

      await store.send(removeAction, (state) {
        return state
          ..counter.favorites = {}
          ..favorites.favorites = {};
      });
    });
  });
}
