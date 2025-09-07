// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension FilePath on File {
  static final id = WritableKeyPath<File, String>(
    get: (obj) => obj.id,
    set: (obj, id) => obj!.copyWith(id: id),
  );
  static final name = WritableKeyPath<File, String>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!.copyWith(name: name),
  );
  static final createdAt = WritableKeyPath<File, DateTime>(
    get: (obj) => obj.createdAt,
    set: (obj, createdAt) => obj!.copyWith(createdAt: createdAt),
  );
  static final path = WritableKeyPath<File, String>(
    get: (obj) => obj.path,
    set: (obj, path) => obj!.copyWith(path: path),
  );
}

mixin _$File {
  String get id;
  String get name;
  DateTime get createdAt;
  String get path;
  File copyWith({String? id, String? name, DateTime? createdAt, String? path}) {
    return File(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      path: path ?? this.path,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is File &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(id, other.id) &&
          const DeepCollectionEquality().equals(name, other.name) &&
          const DeepCollectionEquality().equals(createdAt, other.createdAt) &&
          const DeepCollectionEquality().equals(path, other.path);
  @override
  int get hashCode => Object.hash(runtimeType, id, name, createdAt, path);
  @override
  String toString() {
    return "File(id: $id, name: $name, createdAt: $createdAt, path: $path)";
  }
}

extension MemberPath on Member {
  static final name = WritableKeyPath<Member, String>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!.copyWith(name: name),
  );
}

mixin _$Member {
  String get name;
  Member copyWith({String? name}) {
    return Member(name: name ?? this.name);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(name, other.name);
  @override
  int get hashCode => Object.hash(runtimeType, name);
  @override
  String toString() {
    return "Member(name: $name)";
  }
}

extension SharedFilePath on SharedFile {
  static final file = WritableKeyPath<SharedFile, File>(
    get: (obj) => obj.file,
    set: (obj, file) => obj!.copyWith(file: file),
  );
  static final participants = WritableKeyPath<SharedFile, List<Member>>(
    get: (obj) => obj.participants,
    set: (obj, participants) => obj!.copyWith(participants: participants),
  );
}

mixin _$SharedFile {
  File get file;
  List<Member> get participants;
  SharedFile copyWith({File? file, List<Member>? participants}) {
    return SharedFile(
      file: file ?? this.file,
      participants: participants ?? this.participants,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SharedFile &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(file, other.file) &&
          const DeepCollectionEquality().equals(
            participants,
            other.participants,
          );
  @override
  int get hashCode => Object.hash(runtimeType, file, participants);
  @override
  String toString() {
    return "SharedFile(file: $file, participants: $participants)";
  }
}
