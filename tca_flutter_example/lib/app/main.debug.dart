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
import 'clients/user_preferences_client.dart';
import 'clients/user_preferences_client.mock.dart';
import 'features/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  userPreferencesClient = InMemoryPreferencesClient.items([
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
            testimonial: Shared.x.userPrefs(<Testimonial>[]).get(listPath(0)),
          ),
        ),
      ),
    ),
  );

  final _ = Shared.x
      .userPrefs(<Testimonial>[])
      .getProp(
        (list) => list[0],
        (list, e) => list.set(0, e), //
      );

  final _ = Shared.x
      .userPrefs(testimonial0)
      .getProp(
        (t) => t.recipient,
        (t, r) => t.copyWith(recipient: r), //
      );

  final _ = Shared.x
      .userPrefs(<Testimonial>[]) //
      .get(listPath(0)) //
      .get(TestimonialPath.recipient);

  final _ = Shared.x.userPrefs(<Testimonial>[]).recipient;

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

extension SettableList<T> on List<T> {
  List<T> set(int index, T value) {
    this[index] = value;
    return this;
  }
}

extension on Shared<List<Testimonial>> {
  Shared<Member> get recipient {
    return getProp(
      (list) => list[0].recipient,
      (list, r) => list.set(0, list[0].copyWith(recipient: r)),
    );
  }
}
