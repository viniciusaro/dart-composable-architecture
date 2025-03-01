import 'dart:async';
import 'dart:isolate';

import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper.dart';

final class Int {
  int value;
  Int(this.value);

  @override
  int get hashCode => value.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is Int && other.value == value;
  }

  @override
  String toString() {
    return "Int($value)";
  }
}

void main() {
  Effect<Unit> incrementReducer(Inout<Int> state, Unit action) {
    state.mutate((count) => count..value += 1);
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
      test('syncs state updates between viewed and original', () async {
        final store = Store(
          initialState: Int(0),
          reducer: incrementReducer,
        );

        store.send(unit);
        expect(store.state, Int(1));

        final viewdStore = store.view(
          state: KeyPath.identity(),
          action: KeyPath.identityOptional(),
        );

        viewdStore.send(unit);
        expect(store.state, Int(2));
        expect(viewdStore.state, Int(2));

        store.send(unit);
        expect(store.state, Int(3));
        expect(viewdStore.state, Int(3));
      });

      test('emits every state change on viewed store stream', () async {
        List<Int> storeStateEmissions = [];
        List<Int> viewStoreAStateEmissions = [];
        List<Int> viewStoreBStateEmissions = [];

        final store = Store(
          initialState: Int(0),
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
          storeStateEmissions.add(update.state);
        });

        viewdStoreA.syncStream.listen((update) {
          viewStoreAStateEmissions.add(update.state);
        });

        viewdStoreB.syncStream.listen((update) {
          viewStoreBStateEmissions.add(update.state);
        });

        store.send(unit);
        expect(storeStateEmissions, [Int(1)]);
        expect(viewStoreAStateEmissions, [Int(1)]);
        expect(viewStoreBStateEmissions, [Int(1)]);

        viewdStoreA.send(unit);
        expect(storeStateEmissions, [Int(2), Int(2)]);
        expect(viewStoreAStateEmissions, [Int(2), Int(2)]);
        expect(viewStoreBStateEmissions, [Int(2), Int(2)]);

        viewdStoreB.send(unit);
        expect(storeStateEmissions, [Int(3), Int(3), Int(3)]);
        expect(viewStoreAStateEmissions, [Int(3), Int(3), Int(3)]);
        expect(viewStoreBStateEmissions, [Int(3), Int(3), Int(3)]);
      });
    });
  }, timeout: Timeout(Duration(minutes: 100)));
}

extension ObjectX<T> on T {
  Future<T> isolatedCopy() {
    return Isolate.run(() => this);
  }
}
