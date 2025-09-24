import 'user_preferences_client.mock.dart';

UserPreferencesClient userPreferencesClient =
    UnimplementedUserPreferencesClient();

mixin Decoder<T> {
  T call(Map<String, dynamic> args);
}

mixin Encoder<T> {
  Map<String, dynamic> call(T value);
}

mixin UserPreferencesClient {
  T? get<T>(String key, Decoder<T> decoder);
  T set<T>(String key, T value, Encoder<T> encoder);
}
