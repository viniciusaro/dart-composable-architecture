import 'models/models.dart';

AuthClient authClient = unimplementedAuthClient;

final class AuthClient {
  final Future<User?> Function() getAuthToken;
  final Future<User> Function(String username, String password) login;

  AuthClient({
    required this.getAuthToken,
    required this.login, //
  });
}

final unimplementedAuthClient = AuthClient(
  getAuthToken: () => throw UnimplementedError(),
  login: (user, pass) => throw UnimplementedError(),
);

AuthClient loggedInAuthClient(User user) => AuthClient(
  getAuthToken: () => Future.sync(() => user),
  login: (_, __) => Future.sync(() => user),
);

AuthClient loggedOutAuthClient({required User onLogin}) => AuthClient(
  getAuthToken: () => Future.sync(() => null),
  login: (_, __) => Future.sync(() => onLogin),
);
