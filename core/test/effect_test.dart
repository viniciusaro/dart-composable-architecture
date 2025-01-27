import 'package:composable_architecture/core.dart';
import 'package:test/test.dart';

import '_helper.dart';

void main() {
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
}
