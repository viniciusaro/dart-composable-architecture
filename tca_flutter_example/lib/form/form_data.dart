part of 'form.dart';

@KeyPathable()
final class FormData with _$FormData {
  @override
  final personalInformation = Shared.inMemory(PersonalInformationData());

  @override
  final paymentMethodData = Shared.inMemory(PaymentMethodData());
}
