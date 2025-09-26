import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import '../clients/models/models.dart';
import '../extensions/shared.extensions.dart';

part 'profile.g.dart';

typedef State = ProfileState;
typedef Action = ProfileAction;

@KeyPathable()
final class ProfileState with _$ProfileState {
  @override
  final files = Shared.x.userPrefs(<SharedFile>[]);

  @override
  final testimonials = Shared.x.userPrefs(<Testimonial>[]);
}

@CaseKeyPathable()
sealed class ProfileAction {}

final class ProfileWidget extends StatelessWidget {
  final Store<State, Action> store;

  const ProfileWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore.identity(
      store,
      body: (viewStore) {
        return Scaffold(
          appBar: AppBar(title: Text("Perfil")),
          body: ListView(
            children: [
              Text(
                "# Arquivos: ${viewStore.state.files.value.length}", //
              ),
              Text(
                "# Testimonials: ${viewStore.state.testimonials.value.length}", //
              ),
            ],
          ),
        );
      },
    );
  }
}
