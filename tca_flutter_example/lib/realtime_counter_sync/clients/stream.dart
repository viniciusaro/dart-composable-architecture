part of '../realtime_counter_sync.dart';

extension StreamX<T> on Stream<T> {
  Stream<T> realDistinct() {
    final all = <int>{};

    return map((e) {
      if (all.contains(e.hashCode)) {
        return null;
      }
      all.add(e.hashCode);
      return e;
    }).whereNotNull();
  }
}

extension OptionalStream<T> on Stream<T?> {
  Stream<T> whereNotNull() {
    return where((e) => e != null).map((e) => e!);
  }
}
