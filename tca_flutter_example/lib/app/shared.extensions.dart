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
  switch (tokens.rawTypeName) {
    case "File":
      decoder = FileDecoder();
    case "Member":
      decoder = MemberDecoder();
    case "SharedFile":
      decoder = SharedFileDecoder();
    case "List<SharedFile>":
      decoder = ListDecoder(SharedFileDecoder());
  }

  return decoder;
}

Encoder getEncoder<T>() {
  final tokens = Tokens(T.toString());

  dynamic encoder;
  switch (tokens.rawTypeName) {
    case "File":
      encoder = FileEncoder();
    case "Member":
      encoder = MemberEncoder();
    case "SharedFile":
      encoder = SharedFileEncoder();
    case "List<SharedFile>":
      encoder = ListEncoder(SharedFileEncoder());
  }

  return encoder;
}

final class Tokens {
  final String _raw;

  Tokens(this._raw);

  String get rawTypeName {
    return _raw;
  }

  String get typeName {
    return _raw.contains("<") ? _raw.split("<")[1].replaceAll(">", "") : _raw;
  }

  bool get isList {
    return _raw.startsWith("List<");
  }
}

final class ListEncoder<E> with Encoder<List<E>> {
  final Encoder<E> single;

  ListEncoder(this.single);

  @override
  Map<String, dynamic> call(List<E> value) {
    return {'items': value.map(single.call).toList()};
  }
}

final class ListDecoder<E> with Decoder<List<E>> {
  final Decoder<E> single;

  ListDecoder(this.single);

  @override
  List<E> call(Map<String, dynamic> args) {
    final list = args['items'];
    if (list is! List) {
      return [];
    }
    return (args['items'] as List).map((i) => single.call(i)).toList();
  }
}
