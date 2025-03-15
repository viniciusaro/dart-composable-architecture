// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension SessionPath on Session {
  static final user = WritableKeyPath<Session, User>(
    get: (obj) => obj.user,
    set: (obj, user) => obj!.copyWith(user: user),
  );
}

extension UserPath on User {
  static final name = WritableKeyPath<User, String>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!.copyWith(name: name),
  );
}
