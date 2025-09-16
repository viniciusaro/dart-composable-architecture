import 'shared_preferences_client.mock.dart';

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
