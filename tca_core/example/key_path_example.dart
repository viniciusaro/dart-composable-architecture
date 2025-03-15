import 'package:composable_architecture/composable_architecture.dart';

part 'key_path_example.g.dart';

@KeyPathable()
class App {
  final Session session;
  App(this.session);

  App copyWith({Session? session}) {
    return App(session ?? this.session);
  }
}

@KeyPathable()
class Session {
  final User user;
  Session(this.user);

  Session copyWith({User? user}) {
    return Session(user ?? this.user);
  }
}

@KeyPathable()
class User {
  final UserId id;
  String name;
  User(this.id, this.name);

  User copyWith({UserId? id, String? name}) {
    return User(id ?? this.id, name ?? this.name);
  }
}

@KeyPathable()
class UserId {
  final int value;
  UserId(this.value);

  UserId copyWith({int? value}) {
    return UserId(value ?? this.value);
  }
}

void main() {
  final app = App(Session(User(UserId(2), "Blob")));
  final user = path(AppPath.session, SessionPath.user).get(app);
  final id = path4(AppPath.session, SessionPath.user, UserPath.id, UserIdPath.value).get(app);

  print("user: ${user.id.value}, ${user.name}");
  print("id: $id");
}
