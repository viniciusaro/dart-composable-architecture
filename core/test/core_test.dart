import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

final class AppState extends Equatable {
  final int count;

  AppState({this.count = 0});

  @override
  List<Object?> get props => [count];

  AppState copyWith({required int count}) {
    return AppState(count: count);
  }
}

enum AppAction {
  increment,
  decrement,
}

void main() {
  group('A group of tests', () {
    test('store send updates state', () {
      ReducerResult<AppState, AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            return ReducerResult(
              mutation: (state) => state.copyWith(count: state.count + 1),
            );

          case AppAction.decrement:
            return ReducerResult(
              mutation: (state) => state.copyWith(count: state.count - 1),
            );
        }
      }

      final store = Store(
        initialState: AppState(),
        reducer: reducer,
      );

      store.send(AppAction.increment);
      expect(store.state.count, 1);

      store.send(AppAction.decrement);
      expect(store.state.count, 0);
    });

    test('store send feeds effect action back to system', () async {
      ReducerResult<AppState, AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            return ReducerResult(
              mutation: (state) => state.copyWith(count: state.count + 1),
              effect: Effect.stream(
                () {
                  return Future.delayed(
                    Duration(milliseconds: 10),
                    () => AppAction.decrement,
                  ).asStream();
                },
              ),
            );
          case AppAction.decrement:
            return ReducerResult(
              mutation: (state) => state.copyWith(count: state.count - 1),
            );
        }
      }

      final store = Store(
        initialState: AppState(),
        reducer: reducer,
      );

      store.send(AppAction.increment);
      expect(store.state.count, 1);

      await Future.delayed(Duration(milliseconds: 10));
      expect(store.state.count, 0);
    });

    test('debug reducer prints debug information', () {
      ReducerResult<AppState, AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            return ReducerResult(
              mutation: (state) => state.copyWith(count: state.count + 1),
            );
          case AppAction.decrement:
            return ReducerResult(
              mutation: (state) => state.copyWith(count: state.count - 1),
            );
        }
      }

      var printedLines = <String>[];

      final specification = ZoneSpecification(
        print: (self, parent, zone, line) => printedLines.add(line),
      );

      runZoned(() {
        final store = Store(initialState: AppState(), reducer: debug(reducer));
        store.send(AppAction.increment);
      }, zoneSpecification: specification);

      expect(printedLines, [
        "--------",
        "received action: AppAction.increment",
        "state: AppState(1)",
      ]);
    });
  });
}
