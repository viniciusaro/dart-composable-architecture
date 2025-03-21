import 'dart:async';

import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper.dart';
import '_helper_root_state.dart' hide counterReducer;
import '_helper_shared_state.dart';

void main() {
  Effect<Unit> incrementReducer(Inout<int> state, Unit action) {
    state.mutate((count) => count + 1);
    return Effect.none<Unit>();
  }

  group('store', () {
    group('send', () {
      test('send, updates state', () {
        final store = Store(initialState: AppState(), reducer: counterReducer);

        store.send(AppAction.actionA);
        expect(store.state.count, 1);

        store.send(AppAction.actionB);
        expect(store.state.count, 0);
      });

      test('send, throws error if mutation is detected inside effect',
          () async {
        Effect<AppAction> reducer(Inout<AppState> state, AppAction action) {
          switch (action) {
            case AppAction.actionA:
              return Effect(() {
                state.mutate((s) => s.copyWith(count: s.count + 1));
                return Stream.empty();
              });

            case AppAction.actionB:
              return Effect(() async* {
                state.mutate((s) => s.copyWith(count: s.count + 1));
              });
          }
        }

        final store = Store(
          initialState: AppState(),
          reducer: reducer,
        );

        expect(
          () => store.send(AppAction.actionA),
          throwsA(EffectfullStateMutation()),
        );

        expect(store.state.count, 0);

        Object asyncError = -1;
        runZonedGuarded(
          () => store.send(AppAction.actionB),
          (e, s) => asyncError = e,
        );

        await Future.delayed(Duration.zero);
        expect(asyncError, EffectfullStateMutation());
        expect(store.state.count, 0);
      });

      test('send feeds effect action back into the system', () async {
        Effect<AppAction> reducer(Inout<AppState> state, AppAction action) {
          switch (action) {
            case AppAction.actionA:
              state.mutate((s) => s.copyWith(count: s.count + 1));
              return Effect.stream(
                () => Future.delayed(
                  Duration(milliseconds: 10),
                  () => AppAction.actionB,
                ).asStream(),
              );
            case AppAction.actionB:
              state.mutate((s) => s.copyWith(count: s.count - 1));
              return Effect.none();
          }
        }

        final store = Store(
          initialState: AppState(),
          reducer: reducer,
        );

        store.send(AppAction.actionA);
        expect(store.state.count, 1);

        await Future.delayed(Duration(milliseconds: 10));
        expect(store.state.count, 0);
      });
    });

    group('view', () {
      test('syncs state updates between viewed and original', () {
        final store = Store(
          initialState: 0,
          reducer: incrementReducer,
        );

        store.send(unit);
        expect(store.state, 1);

        final viewdStore = store.view(
          state: KeyPath.identity(),
          action: KeyPath.identityOptional(),
        );

        viewdStore.send(unit);
        expect(store.state, 2);
        expect(viewdStore.state, 2);

        store.send(unit);
        expect(store.state, 3);
        expect(viewdStore.state, 3);
      });

      test('emits every state change on viewed store stream', () {
        List<int> storeStateEmissions = [];
        List<int> viewStoreAStateEmissions = [];
        List<int> viewStoreBStateEmissions = [];

        final store = Store(
          initialState: 0,
          reducer: incrementReducer,
        );

        final viewdStoreA = store.view(
          state: KeyPath.identity(),
          action: KeyPath.identityOptional(),
        );

        final viewdStoreB = viewdStoreA.view(
          state: KeyPath.identity(),
          action: KeyPath.identityOptional(),
        );

        store.syncStream.listen((update) {
          storeStateEmissions.add(update);
        });

        viewdStoreA.syncStream.listen((update) {
          viewStoreAStateEmissions.add(update);
        });

        viewdStoreB.syncStream.listen((update) {
          viewStoreBStateEmissions.add(update);
        });

        store.send(unit);
        expect(storeStateEmissions, [1]);
        expect(viewStoreAStateEmissions, [1]);
        expect(viewStoreBStateEmissions, [1]);

        viewdStoreA.send(unit);
        expect(storeStateEmissions, [1, 2]);
        expect(viewStoreAStateEmissions, [1, 2]);
        expect(viewStoreBStateEmissions, [1, 2]);

        viewdStoreB.send(unit);
        expect(storeStateEmissions, [1, 2, 3]);
        expect(viewStoreAStateEmissions, [1, 2, 3]);
        expect(viewStoreBStateEmissions, [1, 2, 3]);
      });

      test("does not emit state change on unrelated sub state", () {
        int storeEmissionCount = 0;
        int counterStoreEmissionCount = 0;
        int favoritesStoreEmissionCount = 0;

        final store = Store(
          initialState: RootState(),
          reducer: rootReducer,
        );

        final counterStore = store.view(
          state: RootStatePath.counter,
          action: RootActionPath.counter,
        );

        final favoritesStore = store.view(
          state: RootStatePath.favorites,
          action: RootActionPath.favorites,
        );

        store.syncStream.listen((_) {
          storeEmissionCount += 1;
        });

        counterStore.syncStream.listen((_) {
          counterStoreEmissionCount += 1;
        });

        favoritesStore.syncStream.listen((_) {
          favoritesStoreEmissionCount += 1;
        });

        store.send(RootActionEnum.counter(CounterActionEnum.increment()));
        expect(storeEmissionCount, 1);
        expect(counterStoreEmissionCount, 1);
        expect(favoritesStoreEmissionCount, 0);

        store.send(RootActionEnum.favorites(FavoritesActionEnum.add(1)));
        expect(storeEmissionCount, 2);
        expect(counterStoreEmissionCount, 1);
        expect(favoritesStoreEmissionCount, 1);

        counterStore.send(CounterActionEnum.increment());
        expect(storeEmissionCount, 3);
        expect(counterStoreEmissionCount, 2);
        expect(favoritesStoreEmissionCount, 1);

        favoritesStore.send(FavoritesActionEnum.add(2));
        expect(storeEmissionCount, 4);
        expect(counterStoreEmissionCount, 2);
        expect(favoritesStoreEmissionCount, 2);
      });

      test('emits when shared state changes', () {
        int storeEmissionCount = 0;
        int counterAStoreEmissionCount = 0;
        int counterBStoreEmissionCount = 0;

        final store = Store(
          initialState: SharedState(),
          reducer: sharedReducer,
        );

        final counterAStore = store.view(
          state: SharedStatePath.counterA,
          action: SharedActionPath.counterA,
        );

        final counterBStore = store.view(
          state: SharedStatePath.counterB,
          action: SharedActionPath.counterB,
        );

        final nonSharedCounterStore = store.view(
          state: SharedStatePath.nonSharedCounter,
          action: SharedActionPath.nonSharedCounterIncrement,
        );

        store.syncStream.listen((_) {
          storeEmissionCount += 1;
        });

        counterAStore.syncStream.listen((_) {
          counterAStoreEmissionCount += 1;
        });

        counterBStore.syncStream.listen((_) {
          counterBStoreEmissionCount += 1;
        });

        store.send(
          SharedActionEnum.counterA(SharedCounterActionEnum.increment()),
        );
        expect(storeEmissionCount, 1);
        expect(counterAStoreEmissionCount, 1);
        expect(counterBStoreEmissionCount, 1);

        store.send(
          SharedActionEnum.counterB(SharedCounterActionEnum.increment()),
        );
        expect(storeEmissionCount, 2);
        expect(counterAStoreEmissionCount, 2);
        expect(counterBStoreEmissionCount, 2);

        store.send(SharedActionEnum.nonSharedCounterIncrement());
        expect(storeEmissionCount, 3);
        expect(counterAStoreEmissionCount, 2);
        expect(counterBStoreEmissionCount, 2);

        nonSharedCounterStore.send(SharedActionNonSharedCounterIncrement());
        expect(storeEmissionCount, 4);
        expect(counterAStoreEmissionCount, 2);
        expect(counterBStoreEmissionCount, 2);

        counterAStore.send(SharedCounterActionEnum.increment());
        expect(storeEmissionCount, 5);
        expect(counterAStoreEmissionCount, 3);
        expect(counterBStoreEmissionCount, 3);

        counterBStore.send(SharedCounterActionEnum.increment());
        expect(storeEmissionCount, 6);
        expect(counterAStoreEmissionCount, 4);
        expect(counterBStoreEmissionCount, 4);
      });
    });
  });
}
