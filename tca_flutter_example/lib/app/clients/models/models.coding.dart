import '../shared_preferences_client.dart';
import 'models.dart';

final class FileDecoder with Decoder<File> {
  @override
  File call(Map<String, dynamic> args) {
    return File(
      id: args['id'],
      name: args['name'],
      createdAt: args['createdAt'],
      path: args['path'],
    );
  }
}

final class FileEncoder with Encoder<File> {
  @override
  Map<String, dynamic> call(File value) {
    return {
      'id': value.id,
      'name': value.name,
      'createdAt': value.createdAt,
      'path': value.path,
    };
  }
}

final class MemberDecoder with Decoder<Member> {
  @override
  Member call(Map<String, dynamic> args) {
    return Member(name: args['name']);
  }
}

final class MemberEncoder with Encoder<Member> {
  @override
  Map<String, dynamic> call(Member value) {
    return {'name': value.name};
  }
}

final class SharedFileDecoder with Decoder<SharedFile> {
  @override
  SharedFile call(Map<String, dynamic> args) {
    return SharedFile(
      file: FileDecoder().call(args['file']),
      participants:
          (args['participants'] as List)
              .map((p) => MemberDecoder().call(p))
              .toList(),
    );
  }
}

final class SharedFileEncoder with Encoder<SharedFile> {
  @override
  Map<String, dynamic> call(SharedFile value) {
    return {
      'file': FileEncoder().call(value.file),
      'participants': value.participants.map(MemberEncoder().call).toList(),
    };
  }
}
