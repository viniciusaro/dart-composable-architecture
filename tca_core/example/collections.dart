import 'package:composable_architecture/composable_architecture.dart';

part 'collections.g.dart';

@KeyPathable()
final class Session {
  final User user;
  Session(this.user);

  Session copyWith({User? user}) {
    return Session(user ?? this.user);
  }
}

@KeyPathable()
final class User {
  final String name;
  User(this.name);

  User copyWith({String? name}) {
    return User(name ?? this.name);
  }
}

extension IterableKeyPaths<T> on Iterable<T> {
  Iterable<U> mapPath<U>(KeyPath<T, U> keyPath) {
    return map(keyPath.get);
  }
}

void main() {
  final sessions = [Session(User("Blob")), Session(User("Blob Jr."))];
  final names = sessions.mapPath(
    path(SessionPath.user, UserPath.name),
  );
  print("names: $names"); // names: [Blob, Blob Jr.]
}
