import 'dart:async';

import 'package:core/core.dart';
import 'package:test/test.dart';

final class AppState {
  int count = 0;
}

enum AppAction {
  increment,
  decrement,
}

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('store send updates state', () {
      Effect<AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            state.count += 1;
            return Effect.none();
          case AppAction.decrement:
            state.count -= 1;
            return Effect.none();
        }
      }

      final store = Store(initialState: AppState(), reducer: reducer);

      store.send(AppAction.increment);
      expect(store.state.count, 1);

      store.send(AppAction.decrement);
      expect(store.state.count, 0);
    });

    test('store send feeds effect action back to system', () async {
      final delay = Duration(milliseconds: 10);

      Effect<AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            state.count += 1;
            return Effect((send) {
              Future.delayed(delay, () {
                send(AppAction.decrement);
              });
            });
          case AppAction.decrement:
            state.count -= 1;
            return Effect.none();
        }
      }

      final store = Store(initialState: AppState(), reducer: reducer);

      store.send(AppAction.increment);
      expect(store.state.count, 1);

      store.send(AppAction.decrement);
      expect(store.state.count, 0);

      final count = await Future.delayed(delay, () {
        return store.state.count;
      });

      expect(count, -1);
    });

    test('debug reducer prints debug information', () {
      var printedLines = <String>[];

      final specification = ZoneSpecification(
        print: (self, parent, zone, line) => printedLines.add(line),
      );

      Effect<AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            state.count += 1;
            return Effect.none();
          case AppAction.decrement:
            state.count -= 1;
            return Effect.none();
        }
      }

      runZoned(() {
        final store = Store(initialState: AppState(), reducer: debug(reducer));
        store.send(AppAction.increment);
      }, zoneSpecification: specification);

      expect(printedLines, [
        "--------",
        "received action: AppAction.increment",
        "state: Instance of 'AppState'",
      ]);
    });
  });
}
