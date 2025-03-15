// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_path_example.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppPath on App {
  static final session = WritableKeyPath<App, Session>(
    get: (obj) => obj.session,
    set: (obj, session) => obj!.copyWith(session: session),
  );
}

extension SessionPath on Session {
  static final user = WritableKeyPath<Session, User>(
    get: (obj) => obj.user,
    set: (obj, user) => obj!.copyWith(user: user),
  );
}

extension UserPath on User {
  static final id = WritableKeyPath<User, UserId>(
    get: (obj) => obj.id,
    set: (obj, id) => obj!.copyWith(id: id),
  );
  static final name = WritableKeyPath<User, String>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!.copyWith(name: name),
  );
}

extension UserIdPath on UserId {
  static final value = WritableKeyPath<UserId, int>(
    get: (obj) => obj.value,
    set: (obj, value) => obj!.copyWith(value: value),
  );
}
