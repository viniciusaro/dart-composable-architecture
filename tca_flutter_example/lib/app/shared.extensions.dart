import 'package:composable_architecture/composable_architecture.dart';
import 'package:tca_flutter_example/app/clients.dart';
import 'package:tca_flutter_example/app/models.coding.dart';

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
    final value = sharedPreferencesClient.get(T.toString(), getDecoder<T>());
    return value ?? initialValue;
  }

  @override
  void set(T newValue) {
    sharedPreferencesClient.set(T.toString(), newValue, getEncoder<T>());
  }
}

Decoder getDecoder<T>() {
  final tokens = Tokens(T.toString());

  dynamic decoder;
  switch (tokens.typeName) {
    case "File":
      decoder = FileDecoder();
    case "Member":
      decoder = MemberDecoder();
    case "SharedFile":
      decoder = SharedFileDecoder();
    case "SharedFiles":
      decoder = SharedFilesDecoder();
  }

  return decoder;
}

Encoder getEncoder<T>() {
  final tokens = Tokens(T.toString());

  dynamic encoder;
  switch (tokens.typeName) {
    case "File":
      encoder = FileEncoder();
    case "Member":
      encoder = MemberEncoder();
    case "SharedFile":
      encoder = SharedFileEncoder();
    case "SharedFiles":
      encoder = SharedFilesEncoder();
  }

  return encoder;
}

final class Tokens {
  final String _raw;

  Tokens(this._raw);

  String get typeName {
    return _raw.contains("<") ? _raw.split("<")[1].replaceAll(">", "") : _raw;
  }

  bool get isList {
    return _raw.startsWith("List<");
  }
}
