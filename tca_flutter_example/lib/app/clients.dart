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
    if (raw == null) {
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
