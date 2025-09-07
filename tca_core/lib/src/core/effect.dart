part of 'store.dart';

var _cancellableEffects = <int, dynamic>{};
var _effectSubscriptions = <dynamic, dynamic>{};

/// A type that allows transforming side effects into organized and testable
/// return values.
///
/// Effects are useful for dealing with asynchronous computations and make
/// [Reducer]s totally predictable and easy to debug.
///
/// In the Composable Architecture [Effect]s should always return [Action]s,
/// witch will be fed back into the system and be computed
/// by the [Store].
final class Effect<Action> {
  int get _cancellableId => hashCode;
  final Stream<Action> Function() builder;

  Effect(this.builder);

  /// Transforms an [Effect] that emits [Action]s into an [Effect] that
  /// emits [B]s.
  Effect<B> map<B>(B Function(Action) transform) {
    return Effect(() => builder().map(transform));
  }

  /// Returns an Effect that does not emit any action and finishes.
  static Effect<Action> none<Action>() {
    return Effect(() => Stream.empty());
  }

  /// Creates an effect fom a Dart [Stream]. The stream will be subscribed
  /// by a [Store] and every action emited will be forward back into
  /// the system.
  ///
  /// When [onError] is provided, any error emitted by the underlying
  /// stream will be converted into an [Action] (which is emitted first)
  /// and then the same error will be rethrown back into the stream's
  /// error stack.
  static Effect<Action> stream<Action>(
    Stream<Action> Function() builder, {
    Action Function(Object error, StackTrace stackTrace)? onError,
  }) {
    if (onError == null) {
      return Effect(builder);
    }

    return Effect(() {
      final source = builder();
      final controller = StreamController<Action>();

      StreamSubscription<Action>? subscription;
      subscription = source.listen(
        (value) {
          if (!controller.isClosed) {
            controller.add(value);
          } else {
            subscription?.cancel();
          }
        },
        onError: (Object error, StackTrace stackTrace) {
          if (!controller.isClosed) {
            final action = onError(error, stackTrace);
            controller.add(action);
            // Re-emit the error so it bubbles up to the zone if unhandled
            controller.addError(error, stackTrace);
          } else {
            subscription?.cancel();
          }
        },
        onDone: () {
          if (!controller.isClosed) {
            controller.close();
          }
        },
        cancelOnError: false,
      );

      controller.onCancel = () => subscription?.cancel();

      return controller.stream;
    });
  }

  /// Creates an effect fom a Dart [Future]. As soon as the Future returns
  /// a value, it will be forward back into the [Store].
  static Effect<Action> future<Action>(
    Future<Action> Function() builder, {
    Action Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return Effect.stream(
      () => builder().asStream(),
      onError: onError,
    );
  }

  /// Cancels the [Effect] tagged with [id].
  ///
  /// To add cancellation capabilities to an [Effect] one must call the
  /// [cancellable] method before using [Effect.cancel].
  ///
  /// ```dart
  /// enum CounterTimerId { id }
  ///
  /// enum CounterAction { increment, incrementPeriodically, cancelIncrement }
  ///
  /// final class CounterFeature extends Feature<int, CounterAction> {
  ///   @override
  ///   Reducer<int, CounterAction> build() {
  ///     return Reduce((state, action) {
  ///       switch (action) {
  ///         case CounterAction.increment:
  ///           state.mutate((s) => s + 1);
  ///           return Effect.none();
  ///
  ///         case CounterAction.incrementPeriodically:
  ///           return Effect.stream(
  ///             () async* {
  ///               while (true) {
  ///                 await Future.delayed(Duration(seconds: 1));
  ///                 yield CounterAction.increment;
  ///               }
  ///             },
  ///           ).cancellable(CounterTimerId.id);
  ///
  ///         case CounterAction.cancelIncrement:
  ///           return Effect.cancel(CounterTimerId.id);
  ///       }
  ///     });
  ///   }
  /// }
  ///
  /// ```
  static Effect<Action> cancel<ID, Action>(ID id) {
    return Effect<Action>(() {
      _effectSubscriptions[id]?.cancel();
      _effectSubscriptions.remove(id);
      return Stream.empty();
    });
  }

  /// Merges all [effects]. The final stream may emit the elements in a different
  /// order that [effects] is, even if they are all synchronous.
  static Effect<Action> merge<Action>(Iterable<Effect<Action>> effects) {
    return effects.reduce(
      (acc, effect) => acc.merge(effect),
    );
  }

  /// Executes an async computation and finishes without returning any action.
  static Effect<Action> async<Action>(Future<void> Function() body) {
    return Effect(() async* {
      await body();
    });
  }

  /// Executes a sync computation and finishes without returning any action.
  static Effect<Action> sync<Action>(void Function() body) {
    return Effect(() {
      body();
      return Stream.empty();
    });
  }

  /// Creates an Effect that produces [action] and finishes.
  static Effect<Action> action<Action>(Action action) {
    return Effect(() {
      return Stream.value(action);
    });
  }
}

extension CancellableEffect<Action> on Effect<Action> {
  /// Tags an effect with cancellation id, [id].
  ///
  /// Once an effect is made cancellable by calling this method,
  /// it can be cancelled when another effect created
  /// with [Effect.cancel] computes.
  Effect<Action> cancellable<ID>(ID id) {
    final cancellable = Effect(builder);
    _cancellableEffects[cancellable._cancellableId] = id;
    return cancellable;
  }
}

extension CombinableEffect<Action> on Effect<Action> {
  /// Merges [other] with [this], becoming a single Effect that emits
  /// every action from both effects.
  ///
  /// The order of the actions depend on the order internal computations
  /// are made, so there is no pre condition that determines
  /// whether the actions of [other] or [this]
  /// will come first.
  Effect<Action> merge(Effect<Action> other) {
    return Effect(() {
      final controller = StreamController<Action>();
      final id = _cancellableEffects[_cancellableId];
      final otherId = _cancellableEffects[other._cancellableId];

      CancellableSubscription? subscription;
      CancellableSubscription? otherSubscription;

      subscription = CancellableSubscription(builder().listen((value) {
        if (!controller.isClosed) {
          controller.add(value);
        } else {
          subscription?.cancel();
        }
      }));

      otherSubscription =
          CancellableSubscription(other.builder().listen((value) {
        if (!controller.isClosed) {
          controller.add(value);
        } else {
          otherSubscription?.cancel();
        }
      }));
      var thisDone = false;
      var otherDone = false;

      subscription.onDone(() {
        thisDone = true;
        if (otherDone) {
          controller.close();
        }
      });

      otherSubscription.onDone(() {
        otherDone = true;
        if (thisDone) {
          controller.close();
        }
      });

      if (id != null) {
        _effectSubscriptions[id] = subscription;
      }

      if (otherId != null) {
        _effectSubscriptions[otherId] = otherSubscription;
      }

      return controller.stream;
    });
  }
}

class CancellableSubscription<T> {
  final StreamSubscription<T> subscription;
  void Function() _onCancel = () {};
  CancellableSubscription(this.subscription);

  void onDone(void Function() closure) {
    _onCancel = closure;
    subscription.onDone(closure);
  }

  Future<void> cancel() {
    return subscription.cancel().then((_) => _onCancel());
  }
}
