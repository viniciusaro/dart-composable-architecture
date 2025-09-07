import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'text_field_with_value.dart';

part 'personal_information_data.dart';
part 'personal_information.g.dart';

typedef State = PersonalInformationStepState;
typedef Action = PersonalInformationStepAction;

@KeyPathable()
final class PersonalInformationStepState with _$PersonalInformationStepState {
  @override
  final data = Shared.inMemory(PersonalInformationData());
}

@CaseKeyPathable()
sealed class PersonalInformationStepAction<
  OnNameChanged extends String,
  OnEmailChanged extends String,
  OnPhoneChanged extends String,
  OnNextButtonTapped
> {}

final class PersonalInformationStepFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce((state, action) {
      switch (action) {
        case PersonalInformationStepActionOnNameChanged():
          state.value.data.set(
            (d) => d.copyWith(name: action.onNameChanged), //
          );
          return Effect.none();
        case PersonalInformationStepActionOnEmailChanged():
          state.value.data.set(
            (d) => d.copyWith(email: action.onEmailChanged), //
          );
          return Effect.none();
        case PersonalInformationStepActionOnPhoneChanged():
          state.value.data.set(
            (d) => d.copyWith(phone: action.onPhoneChanged), //
          );
          return Effect.none();
        case PersonalInformationStepActionOnNextButtonTapped():
          return Effect.none();
      }
    });
  }
}

final class PersonalInformationStepWidget extends StatelessWidget {
  final Store<PersonalInformationStepState, PersonalInformationStepAction>
  store;

  const PersonalInformationStepWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        final body = Column(
          children: [
            TextFieldWithValue(
              value: viewStore.state.data.value.name,
              hintText: 'Name',
              onChanged: (value) {
                viewStore.send(
                  PersonalInformationStepActionEnum.onNameChanged(value),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFieldWithValue(
              value: viewStore.state.data.value.email,
              hintText: 'Email',
              onChanged: (value) {
                viewStore.send(
                  PersonalInformationStepActionEnum.onEmailChanged(value),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFieldWithValue(
              value: viewStore.state.data.value.phone,
              hintText: 'Phone',
              onChanged: (value) {
                viewStore.send(
                  PersonalInformationStepActionEnum.onPhoneChanged(value),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                viewStore.send(
                  PersonalInformationStepActionEnum.onNextButtonTapped(),
                );
              },
              child: Text('Next'),
            ),
          ],
        );

        return Padding(padding: EdgeInsets.all(16), child: body);
      },
    );
  }
}
