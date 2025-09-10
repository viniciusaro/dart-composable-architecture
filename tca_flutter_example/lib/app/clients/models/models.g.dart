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
  static final createdAt = WritableKeyPath<File, String>(
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
  String get createdAt;
  String get path;
  File copyWith({String? id, String? name, String? createdAt, String? path}) {
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

extension UserPath on User {
  static final name = WritableKeyPath<User, String>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!.copyWith(name: name),
  );
}

mixin _$User {
  String get name;
  User copyWith({String? name}) {
    return User(name: name ?? this.name);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(name, other.name);
  @override
  int get hashCode => Object.hash(runtimeType, name);
  @override
  String toString() {
    return "User(name: $name)";
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

extension SharedFilesPath on SharedFiles {
  static final items = WritableKeyPath<SharedFiles, List<SharedFile>>(
    get: (obj) => obj.items,
    set: (obj, items) => obj!.copyWith(items: items),
  );
}

mixin _$SharedFiles {
  List<SharedFile> get items;
  SharedFiles copyWith({List<SharedFile>? items}) {
    return SharedFiles(items: items ?? this.items);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SharedFiles &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(items, other.items);
  @override
  int get hashCode => Object.hash(runtimeType, items);
  @override
  String toString() {
    return "SharedFiles(items: $items)";
  }
}
