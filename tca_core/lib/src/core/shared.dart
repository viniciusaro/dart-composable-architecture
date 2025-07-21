import 'dart:async';

import 'package:collection/collection.dart';

bool get isExpectedStateClosure => Zone.current[#expectedStateClosure] == true;

mixin SharedSource<T> {
  T get();
  void set(T newValue);
}

final class SharedZoneValues {
  bool didRunSharedSet = false;
}

final class Shared<T> {
  final SharedSource<T> _source;

  Shared(
    SharedSource<T> source,
  ) : _source = isExpectedStateClosure ? ConstSource(source.get()) : source;

  factory Shared.constant(T initialValue) {
    return Shared(ConstSource(initialValue));
  }

  T get value {
    return _source.get();
  }

  Shared<T> set(T Function(T) update) {
    Zone.current[#sharedZoneValues]?.didRunSharedSet = true;
    _source.set(update(_source.get()));
    return Shared<T>(_source);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is Shared<T> &&
        DeepCollectionEquality().equals(other.value, value);
  }

  @override
  String toString() {
    return "Shared<$T>($value)";
  }
}

var _inMemoryStorage = <String, dynamic>{};

final class InMemorySource<T> with SharedSource<T> {
  final T _initialValue;

  const InMemorySource(this._initialValue);

  @override
  T get() {
    _inMemoryStorage.putIfAbsent(T.toString(), () => _initialValue);
    return _inMemoryStorage[T.toString()];
  }

  @override
  void set(T newValue) {
    _inMemoryStorage[T.toString()] = newValue;
  }
}

final class ConstSource<T> with SharedSource<T> {
  final T _value;

  ConstSource(this._value);

  @override
  T get() {
    return _value;
  }

  @override
  void set(T newValue) {
    throw Exception("ConstSource cannot be set");
  }
}
