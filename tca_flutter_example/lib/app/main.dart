import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'clients/auth_client.dart';
import 'clients/auth_client.live.dart';
import 'clients/models/models.dart';
import 'clients/shared_preferences_client.dart';
import 'clients/shared_preferences_client.live.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  sharedPreferencesClient = LiveSharedPreferencesClient(prefs);
  authClient = liveAuthClient(User(name: "Vini"));

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
