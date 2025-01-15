part of 'store.dart';

var _cancellableEffects = <int, dynamic>{};
var _effectSubscriptions = <dynamic, StreamSubscription>{};

final class Effect<Action> {
  int get _cancellableId => hashCode;
  final Stream<Action> Function() builder;

  Effect(this.builder);

  static Effect<Action> none<Action>() {
    return Effect(() => Stream.empty());
  }

  static Effect<Action> stream<Action>(Stream<Action> Function() builder) {
    return Effect(builder);
  }

  static Effect<Action> cancel<ID, Action>(ID id) => Effects.cancel(id);
}

extension Effects<Action> on Effect<Action> {
  static Effect<Action> cancel<ID, Action>(ID id) {
    return Effect<Action>(() {
      _effectSubscriptions[id]?.cancel();
      _effectSubscriptions.remove(id);
      return Stream.empty();
    });
  }
}

extension CancellableEffect<Action> on Effect<Action> {
  Effect<Action> cancellable<ID>(ID id) {
    final cancellable = Effect(builder);
    _cancellableEffects[cancellable._cancellableId] = id;
    return cancellable;
  }
}
