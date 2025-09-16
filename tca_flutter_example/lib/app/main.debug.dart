import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tca_flutter_example/app/extensions/shared.extensions.dart';
import 'package:tca_flutter_example/app/features/testimonial_compose.dart';
import 'package:tca_flutter_example/app/features/testimonials.dart';

import 'features/app.dart';
import 'clients/auth_client.dart';
import 'clients/auth_client.mock.dart';
import 'clients/models/models.dart';
import 'clients/models/models.fixtures.dart';
import 'clients/shared_preferences_client.dart';
import 'clients/shared_preferences_client.mock.dart';
import 'features/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferencesClient = InMemoryPreferencesClient.items([
    [sharedFile0, sharedFile1],
    [testimonial0, testimonial1],
  ]);

  authClient = loggedInAuthClient(User(name: "Vini"));

  final _ = HomeState(
    selectedIndex: 1,
    testimonials: TestimonialsState(
      destination: Presents(
        TestimonialDestinationEnum.testimonialCompose(
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
