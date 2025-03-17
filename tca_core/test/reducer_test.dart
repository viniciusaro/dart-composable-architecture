import 'dart:async';

import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import '_helper.dart';

void main() {
  group('reducer', () {
    test('debug reducer prints debug information', () {
      var printedLines = <String>[];

      final specification = ZoneSpecification(
        print: (self, parent, zone, line) => printedLines.add(line),
      );

      runZoned(
        () {
          final store = Store(
            initialState: AppState(),
            reducer: debug(counterReducer),
          );
          store.send(AppAction.actionA);
        },
        zoneSpecification: specification,
      );

      expect(printedLines, [
        "--------",
        "received action: AppAction.actionA",
        "state: AppState(1)",
      ]);
    });

    test('combine runs every reducer in list', () {
      Effect<AppAction> reducer1(Inout<AppState> state, AppAction action) {
        switch (action) {
          case AppAction.actionA:
            state.mutate((s) => s.copyWith(count: s.count + 10));
            return Effect.none();
          case AppAction.actionB:
            return Effect.none();
        }
      }

      Effect<AppAction> reducer2(Inout<AppState> state, AppAction action) {
        switch (action) {
          case AppAction.actionA:
            state.mutate((s) => s.copyWith(count: s.count + 1));
            return Effect.none();
          case AppAction.actionB:
            return Effect.none();
        }
      }

      final store = Store(
        initialState: AppState(),
        reducer: combine([
          reducer1,
          reducer2,
        ]),
      );

      store.send(AppAction.actionA);
      expect(store.state.count, 11);
    });
  });
}
