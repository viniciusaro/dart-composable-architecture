import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_client.dart';

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
