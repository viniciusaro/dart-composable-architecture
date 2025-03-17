import 'package:composable_architecture/composable_architecture.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import '_helper_counter.dart';

void main() {
  test("increment", () {
    final store = TestStore(
      initialState: CounterState(),
      reducer: counterReducer,
    );

    store.send(
      CounterAction.increment,
      (_) => CounterState(count: 1),
    );

    store.verifyNoPendingActions();
  });

  test("increment repeatedly", () async {
    final store = TestStore(
      initialState: CounterState(),
      reducer: counterReducer,
    );

    fakeAsync((async) {
      store.send(CounterAction.incrementRepeatedly, (s) => s);

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 1));
      async.elapse(Duration(seconds: 1));

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 2));
      async.elapse(Duration(seconds: 1));

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 3));
      async.elapse(Duration(seconds: 1));

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 4));
      async.elapse(Duration(seconds: 1));

      store.verifyNoPendingActions();
    });
  }, timeout: Timeout(Duration(seconds: 10000)));

  test("increment with delay", () async {
    final store = TestStore(
      initialState: CounterState(),
      reducer: counterReducer,
    );

    fakeAsync((async) {
      store.send(CounterAction.incrementWithDelay, (s) => s);

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 1));
      async.elapse(Duration(seconds: 1));

      store.verifyNoPendingActions();
    });
  });

  test("cancall increment repeatedly", () async {
    final store = TestStore(
      initialState: CounterState(),
      reducer: counterReducer,
    );

    fakeAsync((async) {
      store.send(CounterAction.incrementRepeatedly, (s) => s);

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 1));
      async.elapse(Duration(seconds: 1));

      store.receive(CounterAction.increment, (s) => s.copyWith(count: 2));
      async.elapse(Duration(seconds: 1));

      store.send(CounterAction.cancelIncrementRepeatedly, (s) => s);
      async.elapse(Duration(seconds: 1));

      store.verifyNoPendingActions();
    });
  });

  test("invalid state mutation", () {
    final store = TestStore(
      initialState: InvalidCounterState(),
      reducer: invalidCounterReducer,
    );

    expect(
      () => store.send(CounterAction.increment, (state) => state..count = 1),
      throwsA(MutationOfSameInstance()),
    );
  });
}
