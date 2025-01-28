import 'package:key_path/key_path.dart';

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

  final user = getProp(
    path(App.sessionPath, Session.userPath),
    app,
  );

  final id = getProp(
    path4(App.sessionPath, Session.userPath, User.idPath, UserId.valuePath),
    app,
  );

  print("user: ${user.id.value}, ${user.name}");
  print("id: $id");
}
