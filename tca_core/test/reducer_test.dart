import 'dart:async';

import 'package:composable_architecture/composable_architecture.dart';
import 'package:test/test.dart';

import 'unit.dart';

void main() {
  test('debug reducer prints debug information', () {
    var printedLines = <String>[];

    final specification = ZoneSpecification(
      print: (self, parent, zone, line) => printedLines.add(line),
    );

    Effect<Unit> reducer(Inout<int> state, Unit action) {
      state.mutate((s) => s + 1);
      return Effect.none();
    }

    runZoned(
      () {
        final store = Store(
          initialState: 0,
          reducer: Reduce(reducer).debug(),
        );
        store.send(unit);
      },
      zoneSpecification: specification,
    );

    expect(printedLines, [
      "--------",
      "received action: unit",
      "state: 1",
    ]);
  });

  test('combine runs every reducer in list', () {
    Effect<Unit> reducer1(Inout<int> state, Unit action) {
      state.mutate((s) => s + 10);
      return Effect.none();
    }

    Effect<Unit> reducer2(Inout<int> state, Unit action) {
      state.mutate((s) => s + 1);
      return Effect.none();
    }

    final store = Store(
      initialState: 0,
      reducer: Reduce.combine([
        Reduce(reducer1),
        Reduce(reducer2),
      ]),
    );

    store.send(unit);
    expect(store.state, 11);
  });
}
