import 'dart:async';

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
  T? _latestValue;

  void add(T value) {
    if (value != _latestValue || Zone.current[#sharedZoneValues].didRunSharedSet == true) {
      _latestValue = value;
      _notifyListeners(value);
    }
  }

  void setInitialValue(T value) {
    _latestValue = value;
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
