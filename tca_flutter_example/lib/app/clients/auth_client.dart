import 'models/models.dart';

final class AuthClient {
  final Future<User?> Function() getAuthToken;
  AuthClient(this.getAuthToken);
}
