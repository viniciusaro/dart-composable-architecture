import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'clients/auth_client.dart';
import 'clients/models/models.dart';
import 'clients/models/models.fixtures.dart';
import 'clients/shared_preferences_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // sharedPreferencesClient = LiveSharedPreferencesClient(prefs);
  sharedPreferencesClient = InMemoryPreferencesClient.list([
    sharedFile0,
    sharedFile1,
  ]);

  // authClient = loggedOutAuthClient(onLogin: User(name: "Vini"));
  authClient = loggedInAuthClient(User(name: "Vini"));

  runApp(
    MaterialApp(
      home: AppWidget(
        store: Store(
          initialState: AppState(),
          reducer: AppFeature(), //
        ),
      ),
    ),
  );
}
