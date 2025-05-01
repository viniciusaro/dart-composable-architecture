import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/instrumentation/instrumentation.dart';

void main() {
  test('increment', () {
    final store = TestStore(
      initialState: CounterState(),
      reducer: CounterFeature(),
    );

    store.send(
      CounterActionEnum.incrementButtonTapped(),
      (_) => CounterState(1),
    );
  });

  test('analytics', () {
    final events = <String>[];
    analyticsClient = AnalyticsClient(logEvent: events.add);

    final store = TestStore(
      initialState: CounterState(),
      reducer: Analytcs(), //
    );

    store.send(
      CounterActionEnum.incrementButtonTapped(),
      (s) => s, //
    );

    expect(events, ["CounterActionIncrementButtonTapped()"]);
  });

  test('crash logger on mutation', () {
    final errors = <Object>[];
    crashLoggerClient = CrashLoggerClient(
      onError: (e, s) async => errors.add(e),
    );

    final store = TestStore(
      initialState: CounterState(),
      reducer: CounterFeature(throwableMutation: true), //
    );

    try {
      store.send(
        CounterActionEnum.incrementButtonTapped(),
        (s) => s, //
      );
    } catch (_) {}
    ;

    expect(
      (errors.first as Exception).toString(),
      "Exception: divided by zero",
    );
  });

  test('crash logger on effect error emition', () {
    final errors = <Object>[];
    crashLoggerClient = CrashLoggerClient(
      onError: (e, s) async => errors.add(e),
    );

    final store = TestStore(
      initialState: CounterState(),
      reducer: CounterFeature(throwableMutation: true), //
    );

    try {
      store.send(
        CounterActionEnum.incrementButtonTapped(),
        (s) => s, //
      );
    } catch (_) {}
    ;

    expect(
      (errors.first as Exception).toString(),
      "Exception: divided by zero",
    );
  });
}
