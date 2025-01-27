import 'dart:async';

import 'package:core/core.dart';
import 'package:test/test.dart';

// ignore: must_be_immutable
final class AppState extends Equatable {
  int count;

  AppState({this.count = 0});

  AppState copyWith({required int count}) {
    return AppState(count: count);
  }

  @override
  List<Object?> get props => [count];
}

enum AppAction {
  actionA,
  actionB,
}

void main() {
  Effect<AppAction> infinitActionAEffect() => Effect.stream(
        () async* {
          while (true) {
            await Future.delayed(Duration(milliseconds: 10));
            yield AppAction.actionA;
          }
        },
      );

  Effect<AppAction> counterReducer(Inout<AppState> state, AppAction action) {
    switch (action) {
      case AppAction.actionA:
        state.mutate((s) => s.copyWith(count: s.count + 1));
        return Effect.none();
      case AppAction.actionB:
        state.mutate((s) => s.copyWith(count: s.count - 1));
        return Effect.none();
    }
  }

  group('A group of tests', () {
    test('store send updates state', () {
      final store = Store(initialState: AppState(), reducer: counterReducer);

      store.send(AppAction.actionA);
      expect(store.state.count, 1);

      store.send(AppAction.actionB);
      expect(store.state.count, 0);
    });

    test('store send throws error if mutation is detected inside effect', () async {
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

    test('effect merge sends every action into the system', () async {
      Effect<AppAction> reducer(Inout<AppState> state, AppAction action) {
        switch (action) {
          case AppAction.actionA:
            return Effect.merge([
              Effect.stream(() => Stream.value(AppAction.actionB)),
              Effect.stream(() => Stream.value(AppAction.actionB)),
            ]);
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
      await Future.delayed(Duration.zero);
      expect(store.state.count, -2);
    });

    test('effect cancellable works on merged effects', () async {
      Effect<AppAction> reducer(Inout<AppState> state, AppAction action) {
        switch (action) {
          case AppAction.actionA:
            state.mutate((s) => s.copyWith(count: s.count + 1));
            return Effect.merge([
              infinitActionAEffect().cancellable(#infinite1),
              infinitActionAEffect().cancellable(#infinite2),
            ]);
          case AppAction.actionB:
            return Effect.merge([
              Effect.cancel(#infinite1),
              Effect.cancel(#infinite2),
            ]);
        }
      }

      final store = Store(
        initialState: AppState(),
        reducer: reducer,
      );

      store.send(AppAction.actionA);
      store.send(AppAction.actionB);
      await Future.delayed(Duration(milliseconds: 20));
      expect(store.state.count, 1);
    });

    test('effect cancellable works on parent effects', () async {
      Effect<AppAction> reducer(Inout<AppState> state, AppAction action) {
        switch (action) {
          case AppAction.actionA:
            state.mutate((s) => s.copyWith(count: s.count + 1));
            return Effect.merge([
              infinitActionAEffect(),
              infinitActionAEffect(),
            ]).cancellable(#parent);
          case AppAction.actionB:
            return Effect.cancel(#parent);
        }
      }

      final store = Store(
        initialState: AppState(),
        reducer: reducer,
      );

      store.send(AppAction.actionA);
      store.send(AppAction.actionB);
      await Future.delayed(Duration(milliseconds: 20));
      expect(store.state.count, 1);
    });

    test('debug reducer prints debug information', () {
      var printedLines = <String>[];

      final specification = ZoneSpecification(
        print: (self, parent, zone, line) => printedLines.add(line),
      );

      runZoned(() {
        final store = Store(initialState: AppState(), reducer: debug(counterReducer));
        store.send(AppAction.actionA);
      }, zoneSpecification: specification);

      expect(printedLines, [
        "--------",
        "received action: AppAction.actionA",
        "state: AppState(1)",
      ]);
    });
  });
}
