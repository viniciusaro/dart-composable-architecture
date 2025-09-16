import 'auth_client.dart';
import 'models/models.dart';

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
