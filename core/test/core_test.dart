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
    setUp(() {
      // Additional setup goes here.
    });

    test('store send updates state', () {
      Mutation<AppState, AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            return Mutation.mutate(
              (state) => state.copyWith(count: state.count + 1),
              Effect.none(),
            );
          case AppAction.decrement:
            return Mutation.mutate(
              (state) => state.copyWith(count: state.count - 1),
              Effect.none(),
            );
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

      Mutation<AppState, AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            return Mutation.mutate(
              (state) => state.copyWith(count: state.count + 1),
              Effect.run((send) {
                Future.delayed(delay, () {
                  send(AppAction.decrement);
                });
              }),
            );
          case AppAction.decrement:
            return Mutation.mutate(
              (state) => state.copyWith(count: state.count - 1),
              Effect.none(),
            );
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
      Mutation<AppState, AppAction> reducer(AppState state, AppAction action) {
        switch (action) {
          case AppAction.increment:
            return Mutation.mutate(
              (state) => state.copyWith(count: state.count + 1),
              Effect.none(),
            );
          case AppAction.decrement:
            return Mutation.mutate(
              (state) => state.copyWith(count: state.count - 1),
              Effect.none(),
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
        "state: AppState: count: 1",
      ]);
    });
  });
}
