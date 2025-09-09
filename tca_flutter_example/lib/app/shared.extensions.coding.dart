part of 'shared.extensions.dart';

Decoder<T> _getDecoder<T>() {
  final tokens = _Tokens(T.toString());

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

Encoder<T> _getEncoder<T>() {
  final tokens = _Tokens(T.toString());

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

final class _Tokens {
  final String _raw;

  _Tokens(this._raw);

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
