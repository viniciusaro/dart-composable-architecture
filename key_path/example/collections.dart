import 'package:key_path/key_path.dart';

@KeyPathable()
final class Session {
  final User user;
  Session(this.user);
}

@KeyPathable()
final class User {
  final String name;
  User(this.name);
}

extension IterableKeyPaths<T> on Iterable<T> {
  Iterable<U> mapPath<U>(KeyPath<T, U> keyPath) {
    return map(keyPath.get);
  }
}

void main() {
  final sessions = [Session(User("Blob")), Session(User("Blob Jr."))];
  final names = sessions.mapPath(
    path(Session.userPath, User.namePath),
  );
  print("names: $names"); // names: [Blob, Blob Jr.]
}
