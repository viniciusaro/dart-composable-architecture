import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/feature_composition/feature_composition.dart';

void main() {
  group('counter', () {
    test("add to favorites button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(AppActionEnum.counter(CounterActionEnum.addToFavoritesButtonTapped()));
      expect(store.state.counter.favorites, {0});
      expect(store.state.favorites.favorites, {0});
    });

    test("decrement button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(AppActionEnum.counter(CounterActionEnum.decrementButtonTapped()));
      expect(store.state.counter.count, -1);
    });

    test("increment button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(AppActionEnum.counter(CounterActionEnum.incrementButtonTapped()));
      expect(store.state.counter.count, 1);
    });

    test("remove from favorites button tapped", () {
      final store = TestStore(initialState: AppState(), reducer: appReducer);
      store.send(AppActionEnum.counter(CounterActionEnum.removeFromFavoritesButtonTapped()));
      expect(store.state.counter.favorites, <int>{});
      expect(store.state.favorites.favorites, <int>{});
    });
  });
}
