import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';

part 'models.g.dart';

@KeyPathable()
final class File with _$File {
  @override
  final String id;

  @override
  final String name;

  @override
  final String createdAt;

  @override
  final String path;

  const File({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.path, //
  });
}

@KeyPathable()
final class User with _$User {
  @override
  final String name;

  User({required this.name});
}

@KeyPathable()
final class Member with _$Member {
  @override
  final String name;

  Member({required this.name});
}

@KeyPathable()
final class SharedFile with _$SharedFile {
  @override
  final File file;

  @override
  final List<Member> participants;

  SharedFile({required this.file, required this.participants});
}

@KeyPathable()
final class SharedFiles with _$SharedFiles {
  @override
  final List<SharedFile> items;

  SharedFiles({required this.items});
}
