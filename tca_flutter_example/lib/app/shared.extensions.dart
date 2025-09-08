import 'package:composable_architecture/composable_architecture.dart';
import 'package:tca_flutter_example/app/clients.dart';
import 'package:tca_flutter_example/app/models.decoder.dart';

final class UserPreferences<T> with SharedSource<T> {
  @override
  T get() {
    return sharedPreferencesClient.get(T.toString(), getDecoder());
  }

  @override
  void set(T newValue) {
    sharedPreferencesClient.set(T.toString(), newValue, getEncoder());
  }
}

Decoder<T> getDecoder<T>() {
  final typeName = T.toString();
  dynamic decoder;
  switch (typeName) {
    case "File":
      decoder = FileDecoder();
    case "Member":
      decoder = MemberDecoder();
    case "SharedFile":
      decoder = SharedFileDecoder();
  }
  return decoder;
}

Encoder<T> getEncoder<T>() {
  final typeName = T.toString();
  dynamic encoder;
  switch (typeName) {
    case "File":
      encoder = FileEncoder();
    case "Member":
      encoder = MemberEncoder();
    case "SharedFile":
      encoder = SharedFileEncoder();
  }
  return encoder;
}
