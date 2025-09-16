import 'auth_client.mock.dart';
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
