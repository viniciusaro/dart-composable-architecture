mixin SharedSource<T> {
  T get();
  void set(T newValue);
}

final class Shared<T> {
  final SharedSource<T> _source;

  const Shared(
    SharedSource<T> source,
  ) : _source = source;

  T get value => _source.get();
  set value(T newValue) {
    _source.set(newValue);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ _source.get().hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is Shared<T> && other._source.get() == _source.get();
  }
}

var _inMemoryStorage = <String, dynamic>{};

final class InMemorySource<T> with SharedSource<T> {
  final T initialValue;

  const InMemorySource(this.initialValue);

  @override
  T get() {
    _inMemoryStorage.putIfAbsent(T.toString(), () => initialValue);
    return _inMemoryStorage[T.toString()];
  }

  @override
  void set(T newValue) {
    _inMemoryStorage[T.toString()] = newValue;
  }
}
