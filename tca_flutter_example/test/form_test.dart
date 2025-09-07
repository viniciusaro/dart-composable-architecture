import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/form/form.dart';
import 'package:tca_flutter_example/form/payment_method.dart';
import 'package:tca_flutter_example/form/personal_information.dart';
import 'package:tca_flutter_example/form/success.dart';

void main() {
  group('form', () {
    test('updates personal information', () {
      final store = TestStore(
        initialState: FormState(),
        reducer: FormFeature(),
      );

      store.send(
        FormActionEnum.personalInformation(
          PersonalInformationStepActionEnum.onNameChanged('Vini'),
        ),
        overrideSharedValue(
          PersonalInformationData(name: "Vini"),
          (s) => FormState(),
        ),
      );
    });

    test('goes to payment method step on personal information next tap', () {
      final store = TestStore(
        initialState: FormState(),
        reducer: FormFeature(),
      );

      store.send(
        FormActionEnum.personalInformation(
          PersonalInformationStepActionEnum.onNextButtonTapped(),
        ),
        (s) => s.copyWith(step: Presents(FormStepEnum.paymentMethod())),
      );
    });

    test('goes to success step on payment method next tap', () {
      final store = TestStore(
        initialState: FormState(step: Presents(FormStepEnum.paymentMethod())),
        reducer: FormFeature(),
      );

      store.send(
        FormActionEnum.paymentMethod(
          PaymentMethodStepActionEnum.onNextButtonTapped(),
        ),
        (s) => s.copyWith(
          step: Presents(
            FormStepEnum.success(
              SuccessStepState(description: s.data.toString()),
            ),
          ),
        ),
      );
    });

    test('goes back to personal information step on success next tap', () {
      final store = TestStore(
        initialState: FormState(
          step: Presents(
            FormStepEnum.success(SuccessStepState(description: "description")),
          ),
        ),
        reducer: FormFeature(),
      );

      store.send(
        FormActionEnum.success(SuccessStepActionEnum.onSuccessButtonTapped()),
        (s) => s.copyWith(step: Presents(FormStepEnum.personalInformation())),
      );
    });
  });
}
