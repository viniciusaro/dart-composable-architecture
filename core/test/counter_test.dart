import 'package:core/core.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import '../example/counter_example.dart';

void main() {
  group('counter tests', () {
    test('increment repeatedly increments on every second tick', () {
      final store = Store(initialState: CounterState(), reducer: counterReducer);

      fakeAsync((async) {
        store.send(CounterAction.incrementRepeatedly);
        async.elapse(Duration(seconds: 1));
        expect(store.state.count, 1);

        async.elapse(Duration(seconds: 1));
        expect(store.state.count, 2);

        async.elapse(Duration(seconds: 8));
        expect(store.state.count, 10);
      });
    });

    test('increment repeatedly stops repeating after cancellation', () {
      final store = Store(initialState: CounterState(), reducer: counterReducer);

      fakeAsync((async) async {
        store.send(CounterAction.incrementRepeatedly);
        async.elapse(Duration(seconds: 10));
        expect(store.state.count, 10);

        store.send(CounterAction.cancelIncrementRepeatedly);
        async.elapse(Duration(seconds: 10));
        expect(store.state.count, 10);
      });
    });

    test('increment with delay increments after 1 second', () {
      final store = Store(initialState: CounterState(), reducer: counterReducer);

      fakeAsync((async) {
        store.send(CounterAction.incrementWithDelay);
        async.elapse(Duration(seconds: 1));
        expect(store.state.count, 1);

        async.elapse(Duration(seconds: 100));
        expect(store.state.count, 1);
      });
    });
  });
}
