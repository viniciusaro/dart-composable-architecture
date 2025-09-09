import 'package:composable_architecture/composable_architecture.dart';
import 'package:tca_flutter_example/app/clients.dart';
import 'package:tca_flutter_example/app/models.coding.dart';

part 'shared.extensions.coding.dart';

extension SharedX<T> on Shared<T> {
  static Shared<T> userPrefs<T>(T initialValue) {
    return Shared(UserPreferences(initialValue));
  }
}

final class UserPreferences<T> with SharedSource<T> {
  final T initialValue;

  UserPreferences(this.initialValue);

  @override
  T get() {
    final value = sharedPreferencesClient.get(T.toString(), _getDecoder<T>());
    return value ?? initialValue;
  }

  @override
  void set(T newValue) {
    sharedPreferencesClient.set(T.toString(), newValue, _getEncoder<T>());
  }
}
