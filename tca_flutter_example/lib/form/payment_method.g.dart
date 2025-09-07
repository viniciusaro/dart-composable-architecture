// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension PaymentMethodStepStatePath on PaymentMethodStepState {}

mixin _$PaymentMethodStepState {
  Shared<PaymentMethodData> get data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodStepState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data);
  @override
  int get hashCode => Object.hash(runtimeType, data);
  @override
  String toString() {
    return "PaymentMethodStepState(data: $data)";
  }
}

extension PaymentMethodDataPath on PaymentMethodData {
  static final paymentMethod =
      WritableKeyPath<PaymentMethodData, PaymentMethod?>(
        get: (obj) => obj.paymentMethod,
        set:
            (obj, paymentMethod) => obj!.copyWith(paymentMethod: paymentMethod),
      );
}

mixin _$PaymentMethodData {
  PaymentMethod? get paymentMethod;
  PaymentMethodData copyWith({PaymentMethod? paymentMethod}) {
    return PaymentMethodData(
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodData &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            paymentMethod,
            other.paymentMethod,
          );
  @override
  int get hashCode => Object.hash(runtimeType, paymentMethod);
  @override
  String toString() {
    return "PaymentMethodData(paymentMethod: $paymentMethod)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension PaymentMethodStepActionEnum on PaymentMethodStepAction {
  static PaymentMethodStepAction onPaymentMethodChanged(PaymentMethod p) =>
      PaymentMethodStepActionOnPaymentMethodChanged(p);
  static PaymentMethodStepAction onNextButtonTapped() =>
      PaymentMethodStepActionOnNextButtonTapped();
}

final class PaymentMethodStepActionOnPaymentMethodChanged<
  A extends PaymentMethod,
  B
>
    extends PaymentMethodStepAction<A, B> {
  final A onPaymentMethodChanged;
  PaymentMethodStepActionOnPaymentMethodChanged(this.onPaymentMethodChanged)
    : super();

  @override
  int get hashCode => onPaymentMethodChanged.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is PaymentMethodStepActionOnPaymentMethodChanged &&
      other.onPaymentMethodChanged == onPaymentMethodChanged;

  @override
  String toString() {
    return "PaymentMethodStepActionOnPaymentMethodChanged.$onPaymentMethodChanged";
  }
}

final class PaymentMethodStepActionOnNextButtonTapped<
  A extends PaymentMethod,
  B
>
    extends PaymentMethodStepAction<A, B> {
  PaymentMethodStepActionOnNextButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is PaymentMethodStepActionOnNextButtonTapped;

  @override
  String toString() {
    return "PaymentMethodStepActionOnNextButtonTapped()";
  }
}

extension PaymentMethodStepActionPath on PaymentMethodStepAction {
  static final onPaymentMethodChanged =
      WritableKeyPath<PaymentMethodStepAction, PaymentMethod?>(
        get: (action) {
          if (action is PaymentMethodStepActionOnPaymentMethodChanged) {
            return action.onPaymentMethodChanged;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = PaymentMethodStepActionEnum.onPaymentMethodChanged(
              propAction,
            );
          }
          return rootAction!;
        },
      );
  static final onNextButtonTapped = WritableKeyPath<
    PaymentMethodStepAction,
    PaymentMethodStepActionOnNextButtonTapped?
  >(
    get: (action) {
      if (action is PaymentMethodStepActionOnNextButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = PaymentMethodStepActionEnum.onNextButtonTapped();
      }
      return rootAction!;
    },
  );
}
