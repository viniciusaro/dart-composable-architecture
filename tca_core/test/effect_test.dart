import 'package:composable_architecture/src/core/store.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'unit.dart';

final class Count {
  final int count;
  Count(this.count);
}

void main() {
  test('build method returns stream passed as parameter on init', () {
    final stream = Stream.fromIterable([1, 2, 3]);
    final effect = Effect(() => stream);
    expectLater(effect.builder(), emitsInOrder([1, 2, 3]));
  });

  test('map transforms elements using the transform function parameter', () {
    final effect = Effect(() => Stream.fromIterable(["1", "2", "3"]));
    final intEffect = effect.map(int.parse);
    expectLater(intEffect.builder(), emitsInOrder([1, 2, 3]));
  });

  group('initializer', () {
    test('none, returns empty stream', () {
      final effect = Effect.none();
      expectLater(effect.builder(), emitsInOrder([emitsDone]));
    });

    test('stream, uses stream build', () {
      final effect = Effect.stream(() => Stream.fromIterable([1, 2, 3]));
      expectLater(effect.builder(), emitsInOrder([1, 2, 3, emitsDone]));
    });

    test('future, emits future result as stream value', () {
      final effect = Effect.future(() async => 1);
      expectLater(effect.builder(), emitsInOrder([1, emitsDone]));
    });

    test('merge, emits values from all streams', () {
      final effect = Effect.merge([
        Effect.action(1),
        Effect.action(2),
        Effect.action(3),
      ]);

      expectLater(effect.builder(), emitsInAnyOrder([1, 2, 3]));
    });

    test('async, computes async function and returns empty effect', () {
      fakeAsync((async) async {
        bool hasComputed = false;
        final effect = Effect.async(() async {
          await Future.delayed(const Duration(seconds: 1));
          hasComputed = true;
        });

        final stream = effect.builder();
        expectLater(stream, emitsInOrder([emitsDone]));
        async.elapse(Duration(seconds: 1));
        expect(hasComputed, true);
      });
    });

    test('sync, computes sync function and returns empty effect', () {
      bool hasComputed = false;
      final effect = Effect.sync(() => hasComputed = true);
      final stream = effect.builder();
      expectLater(stream, emitsInOrder([emitsDone]));
      expect(hasComputed, true);
    });

    test('action, forwards action into effect as soon as possible and finishes',
        () {
      final effect = Effect.action(1);
      expectLater(effect.builder(), emitsInOrder([1, emitsDone]));
    });
  });

  group('cancellable', () {
    test('Effect.cancel cancels Effect with associated id', () {
      Effect<Unit?> reducer(Inout<Count> state, Unit? action) {
        switch (action) {
          case Unit():
            state.mutate((s) => Count(s.count + 1));
            return Effect.future(
              () => Future.delayed(Duration(seconds: 1)).then((_) => unit),
            ).cancellable(#delay);
          case null:
            return Effect.cancel(#delay);
        }
      }

      final store = Store(initialState: Count(0), reducer: Reduce(reducer));
      fakeAsync((async) {
        store.send(unit);
        store.send(null);
        async.elapse(Duration(seconds: 2));
        expect(store.state.count, 1);
      });
    });
  });

  group('merge', () {
    final unitEffectWithDelay = Effect.future(
      () => Future.delayed(Duration(seconds: 1)).then((_) => unit),
    );

    test('sends every action into the system', () async {
      Effect<Unit?> reducer(Inout<Count> state, Unit? action) {
        switch (action) {
          case Unit():
            return Effect.merge([
              Effect.action(null),
              Effect.action(null),
            ]);
          case null:
            state.mutate((s) => Count(s.count + 1));
            return Effect.none();
        }
      }

      final store = Store(
        initialState: Count(0),
        reducer: Reduce(reducer),
      );

      store.send(unit);
      await Future.delayed(Duration.zero);
      expect(store.state.count, 2);
    });

    test('does not complete until this effect is complete', () async {
      Effect<Unit?> reducer(Inout<Count> state, Unit? action) {
        switch (action) {
          case Unit():
            return Effect.stream<Unit?>(() async* {
              while (state.value.count < 10) {
                yield null;
              }
            }).merge(Effect.none());
          case null:
            state.mutate((s) => Count(s.count + 1));
            return Effect.none();
        }
      }

      final store = Store(
        initialState: Count(0),
        reducer: Reduce(reducer),
      );

      store.send(unit);
      await Future.delayed(const Duration(milliseconds: 10));
      expect(store.state.count, 10);
    });

    test('does not complete until other effect is complete', () async {
      Effect<Unit?> reducer(Inout<Count> state, Unit? action) {
        switch (action) {
          case Unit():
            return Effect.none<Unit?>().merge(Effect.stream(() async* {
              while (state.value.count < 10) {
                yield null;
              }
            }));
          case null:
            state.mutate((s) => Count(s.count + 1));
            return Effect.none();
        }
      }

      final store = Store(
        initialState: Count(0),
        reducer: Reduce(reducer),
      );

      store.send(unit);
      await Future.delayed(const Duration(milliseconds: 10));
      expect(store.state.count, 10);
    });

    test('effect cancellable works on merged effects', () async {
      Effect<Unit?> reducer(Inout<Count> state, Unit? action) {
        switch (action) {
          case Unit():
            state.mutate((s) => Count(s.count + 1));
            return Effect.merge([
              unitEffectWithDelay.cancellable(#delay1),
              unitEffectWithDelay.cancellable(#delay2),
            ]);
          case null:
            return Effect.merge([
              Effect.cancel(#delay1),
              Effect.cancel(#delay2),
            ]);
        }
      }

      final store = Store(
        initialState: Count(0),
        reducer: Reduce(reducer),
      );

      fakeAsync((async) {
        store.send(unit);
        store.send(null);
        async.elapse(Duration(seconds: 2));
        expect(store.state.count, 1);
      });
    });

    test('effect cancellable works on parent merged effect', () async {
      Effect<Unit?> reducer(Inout<Count> state, Unit? action) {
        if (action != null) {
          state.mutate((s) => Count(s.count + 1));
          return Effect.merge([
            unitEffectWithDelay,
            unitEffectWithDelay,
          ]).cancellable(#parent);
        } else {
          return Effect.cancel(#parent);
        }
      }

      final store = Store(
        initialState: Count(0),
        reducer: Reduce(reducer),
      );

      fakeAsync((async) {
        store.send(unit);
        store.send(null);
        async.elapse(Duration(seconds: 2));
        expect(store.state.count, 1);
      });
    });
  });
}
