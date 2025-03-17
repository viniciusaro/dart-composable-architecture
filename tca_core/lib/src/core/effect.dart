part of 'store.dart';

var _cancellableEffects = <int, dynamic>{};
var _effectSubscriptions = <dynamic, dynamic>{};

final class Effect<Action> {
  int get _cancellableId => hashCode;
  final Stream<Action> Function() builder;

  Effect(this.builder);

  Effect<B> map<B>(B Function(Action) transform) {
    return Effect(() => builder().map(transform));
  }

  static Effect<Action> none<Action>() {
    return Effect(() => Stream.empty());
  }

  static Effect<Action> stream<Action>(Stream<Action> Function() builder) {
    return Effect(builder);
  }

  static Effect<Action> future<Action>(Future<Action> Function() builder) {
    return Effect(() => builder().asStream());
  }

  static Effect<Action> cancel<ID, Action>(ID id) {
    return Effects.cancel(id);
  }

  static Effect<Action> merge<Action>(List<Effect<Action>> effects) {
    return Effects.merge(effects);
  }

  static Effect<Action> async<Action>(Future<void> Function() body) {
    return Effect(() async* {
      await body();
    });
  }

  static Effect<Action> sync<Action>(void Function() body) {
    return Effect(() {
      body();
      return Stream.empty();
    });
  }

  static Effect<Action> action<Action>(Action action) {
    return Effect(() {
      return Stream.value(action);
    });
  }
}

extension Effects on Effect {
  static Effect<Action> cancel<ID, Action>(ID id) {
    return Effect<Action>(() {
      _effectSubscriptions[id]?.cancel();
      _effectSubscriptions.remove(id);
      return Stream.empty();
    });
  }

  static Effect<Action> merge<Action>(List<Effect<Action>> effects) {
    return effects.reduce(
      (acc, effect) => acc.merge(effect),
    );
  }
}

extension CancellableEffect<Action> on Effect<Action> {
  Effect<Action> cancellable<ID>(ID id) {
    final cancellable = Effect(builder);
    _cancellableEffects[cancellable._cancellableId] = id;
    return cancellable;
  }
}

extension CombinableEffect<Action> on Effect<Action> {
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
