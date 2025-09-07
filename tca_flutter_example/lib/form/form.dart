import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'payment_method.dart';
import 'personal_information.dart';
import 'success.dart';

part 'form_data.dart';
part 'form.g.dart';

typedef State = FormState;
typedef Action = FormAction;

@KeyPathable()
final class FormState with _$FormState, Presentable {
  @override
  final FormData data;

  @override
  final Presents<FormStep> step;
  FormState({
    Presents<FormStep>? step,
    FormData? data, //
  }) : data = data ?? FormData(),
       step = step ?? Presents(FormStepEnum.personalInformation());
}

@CaseKeyPathable()
sealed class FormStep<
  PersonalInformation extends PersonalInformationStepState,
  PaymentMethod extends PaymentMethodStepState,
  Success extends SuccessStepState
> {}

@CaseKeyPathable()
sealed class FormAction<
  PersonalInformation extends PersonalInformationStepAction,
  PaymentMethod extends PaymentMethodStepAction,
  Success extends SuccessStepAction
> {}

final class FormFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce.combine([
      IfLet(
        state: FormStatePath.step.path(FormStepPath.personalInformation),
        action: FormActionPath.personalInformation,
        reducer: PersonalInformationStepFeature(),
      ),
      IfLet(
        state: FormStatePath.step.path(FormStepPath.paymentMethod),
        action: FormActionPath.paymentMethod,
        reducer: PaymentMethodStepFeature(),
      ),
      IfLet(
        state: FormStatePath.step.path(FormStepPath.success),
        action: FormActionPath.success,
        reducer: SuccessStepFeature(),
      ),
      Reduce((state, action) {
        switch (action) {
          case FormActionPersonalInformation():
            final personalAction = action.personalInformation;
            switch (personalAction) {
              case PersonalInformationStepActionOnNextButtonTapped():
                state.mutate(
                  (s) => s.copyWith(
                    step: Presents(FormStepEnum.paymentMethod()), //
                  ),
                );
                return Effect.none();
              default:
                return Effect.none();
            }
          case FormActionPaymentMethod():
            final paymentAction = action.paymentMethod;
            switch (paymentAction) {
              case PaymentMethodStepActionOnNextButtonTapped():
                state.mutate(
                  (s) => s.copyWith(
                    step: Presents(
                      FormStepEnum.success(
                        SuccessStepState(description: s.data.toString()),
                      ),
                    ),
                  ),
                );
                return Effect.none();
              default:
                return Effect.none();
            }
          case FormActionSuccess():
            final successAction = action.success;
            switch (successAction) {
              case SuccessStepActionOnSuccessButtonTapped():
                state.mutate(
                  (s) => s.copyWith(
                    step: Presents(FormStepEnum.personalInformation()),
                  ),
                );
                return Effect.none();
            }
        }
      }),
    ]);
  }
}

final class FormWidget extends StatelessWidget {
  final Store<FormState, FormAction> store;

  const FormWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final personalInformationPath = FormStatePath.step.path(
      FormStepPath.personalInformation,
    );
    final paymentMethodPath = FormStatePath.step.path(
      FormStepPath.paymentMethod,
    );
    final successPath = FormStatePath.step.path(
      FormStepPath.success, //
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Form example')),
      body: WithViewStore(
        store,
        body: (viewStore) {
          switch (viewStore.state.step.value) {
            case FormStepPersonalInformation():
              final store = viewStore.view(
                state: personalInformationPath,
                action: FormActionPath.personalInformation,
              );
              return PersonalInformationStepWidget(store: store!);
            case FormStepPaymentMethod():
              final store = viewStore.view(
                state: paymentMethodPath,
                action: FormActionPath.paymentMethod,
              );
              return PaymentMethodStepWidget(store: store!);
            case FormStepSuccess():
              final store = viewStore.view(
                state: successPath,
                action: FormActionPath.success,
              );
              return SuccessStepWidget(store: store!);
          }
        },
      ),
    );
  }
}

void main() {
  Shared(
    InMemorySource(
      PersonalInformationData(
        name: "John Doe",
        email: "john@doe.com",
        phone: "1234567890",
      ),
    ),
  );

  runApp(
    MaterialApp(
      home: FormWidget(
        store: Store(
          initialState: FormState(),
          reducer: FormFeature().debug(), //
        ),
      ),
    ),
  );
}
