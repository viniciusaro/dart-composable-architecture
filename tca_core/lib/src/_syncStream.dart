part of 'store.dart';

final class SyncStreamSubscription<T> {
  int get id => hashCode;
  final void Function(int) _onCancel;
  SyncStreamSubscription(this._onCancel);

  void cancel() {
    _onCancel(id);
  }
}

final class SyncStream<T> {
  final Map<int, void Function(T)> _listeners = {};

  void _add(T value) {
    _notifyListeners(value);
  }

  void _notifyListeners(T value) {
    for (final listener in _listeners.values) {
      listener(value);
    }
  }

  SyncStreamSubscription<T> listen(void Function(T) onData) {
    final subscription = SyncStreamSubscription<T>(_listeners.remove);
    _listeners[subscription.id] = onData;
    return subscription;
  }
}
