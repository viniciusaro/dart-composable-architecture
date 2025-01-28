# Dart Key Paths

Key Paths are macro generated objects that can be used as getters and setters in generic algorithms.
They allow writing code that depends on access to objects without actually having that access.

## Map Example
```dart
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

```