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

  test('catchErrors captures synchronous reducer errors', () {
    Object? capturedError;
    StackTrace? capturedStack;
    int capturedState = -1;
    Object? capturedAction;

    Effect<Unit> throwingReducer(Inout<int> state, Unit action) {
      throw StateError('sync error');
    }

    final store = Store(
      initialState: 0,
      reducer: Reduce(throwingReducer).catchErrors(
        (error, stack, state, action) {
          capturedError = error;
          capturedStack = stack;
          capturedState = state;
          capturedAction = action;
        },
      ),
    );

    // Should not throw out of send; error is captured
    store.send(unit);

    expect(capturedError is StateError, true);
    expect(capturedStack != null, true);
    expect(capturedState, 0);
    expect(capturedAction, unit);
    expect(store.state, 0);
  });

  test('catchErrors captures errors thrown when building the effect stream',
      () async {
    Object? capturedError;
    StackTrace? capturedStack;
    int capturedState = -1;
    Object? capturedAction;

    Effect<Unit> reducer(Inout<int> state, Unit action) {
      return Effect(() {
        throw StateError('builder error');
      });
    }

    final store = Store(
      initialState: 0,
      reducer: Reduce(reducer).catchErrors(
        (error, stack, state, action) {
          capturedError = error;
          capturedStack = stack;
          capturedState = state;
          capturedAction = action;
        },
      ),
    );

    store.send(unit);

    // Give microtask queue a chance in case anything was scheduled
    await Future<void>.delayed(Duration(milliseconds: 10));

    expect(capturedError is StateError, true);
    expect(capturedStack != null, true);
    expect(capturedState, 0);
    expect(capturedAction, unit);
    expect(store.state, 0);
  });

  test('catchErrors captures errors emitted by the effect stream', () async {
    Object? capturedError;
    StackTrace? capturedStack;
    int capturedState = -1;
    Object? capturedAction;

    Effect<Unit> reducer(Inout<int> state, Unit action) {
      return Effect(() => Stream<Unit>.error(StateError('stream error')));
    }

    final store = Store(
      initialState: 0,
      reducer: Reduce(reducer).catchErrors(
        (error, stack, state, action) {
          capturedError = error;
          capturedStack = stack;
          capturedState = state;
          capturedAction = action;
        },
      ),
    );

    store.send(unit);

    // Allow the stream to emit the error
    await Future<void>.delayed(Duration(milliseconds: 10));

    expect(capturedError is StateError, true);
    expect(capturedStack != null, true);
    expect(capturedState, 0);
    expect(capturedAction, unit);
    expect(store.state, 0);
  });
}
