// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension FormStatePath on FormState {
  static final data = WritableKeyPath<FormState, FormData>(
    get: (obj) => obj.data,
    set: (obj, data) => obj!.copyWith(data: data),
  );
  static final step = WritableKeyPath<
    FormState,
    Presents<
      FormStep<
        PersonalInformationStepState,
        PaymentMethodStepState,
        SuccessStepState
      >
    >
  >(get: (obj) => obj.step, set: (obj, step) => obj!.copyWith(step: step));
}

mixin _$FormState {
  FormData get data;
  Presents<
    FormStep<
      PersonalInformationStepState,
      PaymentMethodStepState,
      SuccessStepState
    >
  >
  get step;
  FormState copyWith({
    FormData? data,
    Presents<
      FormStep<
        PersonalInformationStepState,
        PaymentMethodStepState,
        SuccessStepState
      >
    >?
    step,
  }) {
    return FormState(data: data ?? this.data, step: step ?? this.step);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data) &&
          const DeepCollectionEquality().equals(step, other.step);
  @override
  int get hashCode => Object.hash(runtimeType, data, step);
  @override
  String toString() {
    return "FormState(data: $data, step: $step)";
  }
}

extension FormDataPath on FormData {
  static final personalInformation =
      KeyPath<FormData, Shared<PersonalInformationData>>(
        get: (obj) => obj.personalInformation,
      );
  static final paymentMethodData = KeyPath<FormData, Shared<PaymentMethodData>>(
    get: (obj) => obj.paymentMethodData,
  );
}

mixin _$FormData {
  Shared<PersonalInformationData> get personalInformation;
  Shared<PaymentMethodData> get paymentMethodData;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormData &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            personalInformation,
            other.personalInformation,
          ) &&
          const DeepCollectionEquality().equals(
            paymentMethodData,
            other.paymentMethodData,
          );
  @override
  int get hashCode =>
      Object.hash(runtimeType, personalInformation, paymentMethodData);
  @override
  String toString() {
    return "FormData(personalInformation: $personalInformation, paymentMethodData: $paymentMethodData)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension FormStepEnum on FormStep {
  static FormStep personalInformation([PersonalInformationStepState? p]) =>
      FormStepPersonalInformation(p ?? PersonalInformationStepState());
  static FormStep paymentMethod([PaymentMethodStepState? p]) =>
      FormStepPaymentMethod(p ?? PaymentMethodStepState());
  static FormStep success(SuccessStepState p) => FormStepSuccess(p);
}

final class FormStepPersonalInformation<
  A extends PersonalInformationStepState,
  B extends PaymentMethodStepState,
  C extends SuccessStepState
>
    extends FormStep<A, B, C> {
  final A personalInformation;
  FormStepPersonalInformation(this.personalInformation) : super();

  @override
  int get hashCode => personalInformation.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FormStepPersonalInformation &&
      other.personalInformation == personalInformation;

  @override
  String toString() {
    return "FormStepPersonalInformation.$personalInformation";
  }
}

final class FormStepPaymentMethod<
  A extends PersonalInformationStepState,
  B extends PaymentMethodStepState,
  C extends SuccessStepState
>
    extends FormStep<A, B, C> {
  final B paymentMethod;
  FormStepPaymentMethod(this.paymentMethod) : super();

  @override
  int get hashCode => paymentMethod.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FormStepPaymentMethod && other.paymentMethod == paymentMethod;

  @override
  String toString() {
    return "FormStepPaymentMethod.$paymentMethod";
  }
}

final class FormStepSuccess<
  A extends PersonalInformationStepState,
  B extends PaymentMethodStepState,
  C extends SuccessStepState
>
    extends FormStep<A, B, C> {
  final C success;
  FormStepSuccess(this.success) : super();

  @override
  int get hashCode => success.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FormStepSuccess && other.success == success;

  @override
  String toString() {
    return "FormStepSuccess.$success";
  }
}

extension FormStepPath on FormStep {
  static final personalInformation =
      WritableKeyPath<FormStep, PersonalInformationStepState?>(
        get: (action) {
          if (action is FormStepPersonalInformation) {
            return action.personalInformation;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FormStepEnum.personalInformation(propAction);
          }
          return rootAction!;
        },
      );
  static final paymentMethod =
      WritableKeyPath<FormStep, PaymentMethodStepState?>(
        get: (action) {
          if (action is FormStepPaymentMethod) {
            return action.paymentMethod;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FormStepEnum.paymentMethod(propAction);
          }
          return rootAction!;
        },
      );
  static final success = WritableKeyPath<FormStep, SuccessStepState?>(
    get: (action) {
      if (action is FormStepSuccess) {
        return action.success;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = FormStepEnum.success(propAction);
      }
      return rootAction!;
    },
  );
}

extension FormActionEnum on FormAction {
  static FormAction personalInformation(
    PersonalInformationStepAction<String, String, String, dynamic> p,
  ) => FormActionPersonalInformation(p);
  static FormAction paymentMethod(
    PaymentMethodStepAction<PaymentMethod, dynamic> p,
  ) => FormActionPaymentMethod(p);
  static FormAction success(SuccessStepAction<dynamic> p) =>
      FormActionSuccess(p);
}

final class FormActionPersonalInformation<
  A extends PersonalInformationStepAction<String, String, String, dynamic>,
  B extends PaymentMethodStepAction<PaymentMethod, dynamic>,
  C extends SuccessStepAction<dynamic>
>
    extends FormAction<A, B, C> {
  final A personalInformation;
  FormActionPersonalInformation(this.personalInformation) : super();

  @override
  int get hashCode => personalInformation.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FormActionPersonalInformation &&
      other.personalInformation == personalInformation;

  @override
  String toString() {
    return "FormActionPersonalInformation.$personalInformation";
  }
}

final class FormActionPaymentMethod<
  A extends PersonalInformationStepAction<String, String, String, dynamic>,
  B extends PaymentMethodStepAction<PaymentMethod, dynamic>,
  C extends SuccessStepAction<dynamic>
>
    extends FormAction<A, B, C> {
  final B paymentMethod;
  FormActionPaymentMethod(this.paymentMethod) : super();

  @override
  int get hashCode => paymentMethod.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FormActionPaymentMethod && other.paymentMethod == paymentMethod;

  @override
  String toString() {
    return "FormActionPaymentMethod.$paymentMethod";
  }
}

final class FormActionSuccess<
  A extends PersonalInformationStepAction<String, String, String, dynamic>,
  B extends PaymentMethodStepAction<PaymentMethod, dynamic>,
  C extends SuccessStepAction<dynamic>
>
    extends FormAction<A, B, C> {
  final C success;
  FormActionSuccess(this.success) : super();

  @override
  int get hashCode => success.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is FormActionSuccess && other.success == success;

  @override
  String toString() {
    return "FormActionSuccess.$success";
  }
}

extension FormActionPath on FormAction {
  static final personalInformation = WritableKeyPath<
    FormAction,
    PersonalInformationStepAction<String, String, String, dynamic>?
  >(
    get: (action) {
      if (action is FormActionPersonalInformation) {
        return action.personalInformation;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = FormActionEnum.personalInformation(propAction);
      }
      return rootAction!;
    },
  );
  static final paymentMethod = WritableKeyPath<
    FormAction,
    PaymentMethodStepAction<PaymentMethod, dynamic>?
  >(
    get: (action) {
      if (action is FormActionPaymentMethod) {
        return action.paymentMethod;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = FormActionEnum.paymentMethod(propAction);
      }
      return rootAction!;
    },
  );
  static final success =
      WritableKeyPath<FormAction, SuccessStepAction<dynamic>?>(
        get: (action) {
          if (action is FormActionSuccess) {
            return action.success;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FormActionEnum.success(propAction);
          }
          return rootAction!;
        },
      );
}
