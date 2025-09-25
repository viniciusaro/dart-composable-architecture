import 'package:composable_architecture/composable_architecture.dart';

import '../clients/user_preferences_client.dart';
import '../clients/models/models.coding.dart';

part 'shared.extensions.coding.dart';

extension SharedX on SharedExtensions {
  Shared<T> userPrefs<T>(T initialValue) {
    return Shared(UserPreferences(initialValue));
  }

  Shared<T> firebase<T>(T initialValue) {
    return Shared(Firebase(initialValue));
  }
}

final class UserPreferences<T> with SharedSource<T> {
  final T initialValue;

  UserPreferences(this.initialValue);

  @override
  T get() {
    final value = userPreferencesClient.get(T.toString(), _getDecoder<T>());
    return value ?? initialValue;
  }

  @override
  void set(T newValue) {
    userPreferencesClient.set(T.toString(), newValue, _getEncoder<T>());
  }

  @override
  Stream<T> listen() {
    throw UnimplementedError();
  }
}

final class Firebase<T> with SharedSource<T> {
  final T initialValue;

  Firebase(this.initialValue);

  @override
  T get() {
    throw UnimplementedError();
  }

  @override
  void set(T newValue) {
    throw UnimplementedError();
  }

  @override
  Stream<T> listen() {
    throw UnimplementedError();
  }
}
