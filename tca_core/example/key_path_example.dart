import 'package:composable_architecture/composable_architecture.dart';

part 'key_path_example.g.dart';

@KeyPathable()
class App {
  final Session session;
  App(this.session);
}

@KeyPathable()
class Session {
  final User user;
  Session(this.user);
}

@KeyPathable()
class User {
  final UserId id;
  String name;
  User(this.id, this.name);
}

@KeyPathable()
class UserId {
  final int value;
  UserId(this.value);
}

void main() {
  final app = App(Session(User(UserId(2), "Blob")));
  final user = path(AppPath.session, SessionPath.user).get(app);
  final id = path4(AppPath.session, SessionPath.user, UserPath.id, UserIdPath.value).get(app);

  print("user: ${user.id.value}, ${user.name}");
  print("id: $id");
}
