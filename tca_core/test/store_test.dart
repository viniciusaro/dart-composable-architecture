import 'dart:async';

import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper.dart';

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

      test('send, throws error if mutation is detected inside effect', () async {
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
        expect(viewStoreAStateEmissions, [1, 2, 2]);
        expect(viewStoreBStateEmissions, [1, 2, 2]);

        viewdStoreB.send(unit);
        expect(storeStateEmissions, [1, 2, 3]);
        expect(viewStoreAStateEmissions, [1, 2, 2, 3, 3]);
        expect(viewStoreBStateEmissions, [1, 2, 2, 3, 3, 3]);
      });
    });
  });
}
