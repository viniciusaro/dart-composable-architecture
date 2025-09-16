import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tca_flutter_example/app/shared.extensions.dart';
import 'package:tca_flutter_example/app/testimonial_compose.dart';
import 'package:tca_flutter_example/app/testimonials.dart';

import 'app.dart';
import 'clients/auth_client.dart';
import 'clients/models/models.dart';
import 'clients/models/models.fixtures.dart';
import 'clients/shared_preferences_client.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // sharedPreferencesClient = LiveSharedPreferencesClient(prefs);
  sharedPreferencesClient = InMemoryPreferencesClient.items([
    [sharedFile0, sharedFile1],
    [testimonial0, testimonial1],
  ]);

  // authClient = loggedOutAuthClient(onLogin: User(name: "Vini"));
  authClient = loggedInAuthClient(User(name: "Vini"));

  final _ = HomeState(
    selectedIndex: 1,
    testimonials: TestimonialsState(
      destination: Presents(
        TestimonialDestinationEnum.testimonialComposition(
          TestimonialComposeState(
            testimonial: SharedX.userPrefs(<Testimonial>[]).get(listPath(0)),
          ),
        ),
      ),
    ),
  );

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
