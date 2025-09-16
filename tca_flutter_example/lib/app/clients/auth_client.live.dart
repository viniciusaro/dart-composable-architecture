import 'auth_client.dart';
import 'models/models.dart';

AuthClient liveAuthClient(User user) => AuthClient(
  getAuthToken: () => Future.sync(() => user),
  login: (_, __) => Future.sync(() => user),
);
