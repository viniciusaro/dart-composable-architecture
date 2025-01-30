import 'dart:async';

import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper.dart';

void main() {
  group('store', () {
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

    test('store send feeds effect action back into the system', () async {
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
}
