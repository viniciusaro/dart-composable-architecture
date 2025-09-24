import 'user_preferences_client.dart';

final class UnimplementedUserPreferencesClient with UserPreferencesClient {
  @override
  T? get<T>(String key, Decoder<T> decoder) {
    throw UnimplementedError();
  }

  @override
  T set<T>(String key, T value, Encoder<T> encoder) {
    throw UnimplementedError();
  }
}

final class FixedPreferencesClient<A> with UserPreferencesClient {
  final List<A> items;

  FixedPreferencesClient({required this.items});

  @override
  T? get<T>(String key, Decoder<T> decoder) {
    final type = T.toString();
    if (type == "List<${A.toString()}>") {
      return items as T;
    }
    if (type == A.toString()) {
      return items[0] as T;
    }
    return null;
  }

  @override
  T set<T>(String key, T value, Encoder<T> encoder) {
    return value;
  }
}

final class InMemoryPreferencesClient with UserPreferencesClient {
  final Map<String, dynamic> _storage;

  InMemoryPreferencesClient({Map<String, dynamic>? storage})
    : _storage = storage ?? {};

  static InMemoryPreferencesClient list<T extends Object>(List<T> items) {
    return InMemoryPreferencesClient(storage: {"List<${T.toString()}>": items});
  }

  static InMemoryPreferencesClient items(List items) {
    final entries = items.map((i) => MapEntry(i.runtimeType.toString(), i));
    return InMemoryPreferencesClient(storage: Map.fromEntries(entries));
  }

  @override
  T? get<T>(String key, Decoder<T> decoder) {
    final value = _storage[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  @override
  T set<T>(String key, T value, Encoder<T> encoder) {
    _storage[key] = value;
    return value;
  }
}
