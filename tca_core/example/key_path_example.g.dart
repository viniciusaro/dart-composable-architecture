// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_path_example.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppPath on App {
  static final session = KeyPath<App, Session>(
    get: (obj) => obj.session,
  );
}

extension SessionPath on Session {
  static final user = KeyPath<Session, User>(
    get: (obj) => obj.user,
  );
}

extension UserPath on User {
  static final id = KeyPath<User, UserId>(
    get: (obj) => obj.id,
  );
  static final name = WritableKeyPath<User, String>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!..name = name,
  );
}

extension UserIdPath on UserId {
  static final value = KeyPath<UserId, int>(
    get: (obj) => obj.value,
  );
}
