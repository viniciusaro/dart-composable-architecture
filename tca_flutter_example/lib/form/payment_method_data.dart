part of 'payment_method.dart';

@KeyPathable()
final class PaymentMethodData with _$PaymentMethodData {
  @override
  final PaymentMethod? paymentMethod;

  const PaymentMethodData({this.paymentMethod});
}
