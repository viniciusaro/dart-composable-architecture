import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferencesClient sharedPreferencesClient =
    UnimplementedSharedPreferencesClient();

mixin Decoder<T> {
  T call(Map<String, dynamic> args);
}

mixin Encoder<T> {
  Map<String, dynamic> call(T value);
}

mixin SharedPreferencesClient {
  T? get<T>(String key, Decoder<T> decoder);
  T set<T>(String key, T value, Encoder<T> encoder);
}

final class UnimplementedSharedPreferencesClient with SharedPreferencesClient {
  @override
  T? get<T>(String key, Decoder<T> decoder) {
    throw UnimplementedError();
  }

  @override
  T set<T>(String key, T value, Encoder<T> encoder) {
    throw UnimplementedError();
  }
}

final class LiveSharedPreferencesClient with SharedPreferencesClient {
  final SharedPreferences _prefs;

  LiveSharedPreferencesClient(this._prefs);

  @override
  T? get<T>(String key, Decoder<T> decoder) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final decoded = Map<String, dynamic>.from(json.decode(raw));
    return decoder(decoded);
  }

  @override
  T set<T>(String key, T value, Encoder<T> encoder) {
    final raw = encoder(value);
    final encoded = json.encode(raw);
    _prefs.setString(key, encoded);
    return value;
  }
}

final class FixedPreferencesClient<A> with SharedPreferencesClient {
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

final class InMemoryPreferencesClient with SharedPreferencesClient {
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
