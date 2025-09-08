// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_information.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension PersonalInformationStepStatePath on PersonalInformationStepState {
  static final data =
      KeyPath<PersonalInformationStepState, Shared<PersonalInformationData>>(
        get: (obj) => obj.data,
      );
}

mixin _$PersonalInformationStepState {
  Shared<PersonalInformationData> get data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalInformationStepState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data);
  @override
  int get hashCode => Object.hash(runtimeType, data);
  @override
  String toString() {
    return "PersonalInformationStepState(data: $data)";
  }
}

extension PersonalInformationDataPath on PersonalInformationData {
  static final name = WritableKeyPath<PersonalInformationData, String?>(
    get: (obj) => obj.name,
    set: (obj, name) => obj!.copyWith(name: name),
  );
  static final email = WritableKeyPath<PersonalInformationData, String?>(
    get: (obj) => obj.email,
    set: (obj, email) => obj!.copyWith(email: email),
  );
  static final phone = WritableKeyPath<PersonalInformationData, String?>(
    get: (obj) => obj.phone,
    set: (obj, phone) => obj!.copyWith(phone: phone),
  );
}

mixin _$PersonalInformationData {
  String? get name;
  String? get email;
  String? get phone;
  PersonalInformationData copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return PersonalInformationData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalInformationData &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(name, other.name) &&
          const DeepCollectionEquality().equals(email, other.email) &&
          const DeepCollectionEquality().equals(phone, other.phone);
  @override
  int get hashCode => Object.hash(runtimeType, name, email, phone);
  @override
  String toString() {
    return "PersonalInformationData(name: $name, email: $email, phone: $phone)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension PersonalInformationStepActionEnum on PersonalInformationStepAction {
  static PersonalInformationStepAction onNameChanged(String p) =>
      PersonalInformationStepActionOnNameChanged(p);
  static PersonalInformationStepAction onEmailChanged(String p) =>
      PersonalInformationStepActionOnEmailChanged(p);
  static PersonalInformationStepAction onPhoneChanged(String p) =>
      PersonalInformationStepActionOnPhoneChanged(p);
  static PersonalInformationStepAction onNextButtonTapped() =>
      PersonalInformationStepActionOnNextButtonTapped();
}

final class PersonalInformationStepActionOnNameChanged<
  A extends String,
  B extends String,
  C extends String,
  D
>
    extends PersonalInformationStepAction<A, B, C, D> {
  final A onNameChanged;
  PersonalInformationStepActionOnNameChanged(this.onNameChanged) : super();

  @override
  int get hashCode => onNameChanged.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is PersonalInformationStepActionOnNameChanged &&
      other.onNameChanged == onNameChanged;

  @override
  String toString() {
    return "PersonalInformationStepActionOnNameChanged.$onNameChanged";
  }
}

final class PersonalInformationStepActionOnEmailChanged<
  A extends String,
  B extends String,
  C extends String,
  D
>
    extends PersonalInformationStepAction<A, B, C, D> {
  final B onEmailChanged;
  PersonalInformationStepActionOnEmailChanged(this.onEmailChanged) : super();

  @override
  int get hashCode => onEmailChanged.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is PersonalInformationStepActionOnEmailChanged &&
      other.onEmailChanged == onEmailChanged;

  @override
  String toString() {
    return "PersonalInformationStepActionOnEmailChanged.$onEmailChanged";
  }
}

final class PersonalInformationStepActionOnPhoneChanged<
  A extends String,
  B extends String,
  C extends String,
  D
>
    extends PersonalInformationStepAction<A, B, C, D> {
  final C onPhoneChanged;
  PersonalInformationStepActionOnPhoneChanged(this.onPhoneChanged) : super();

  @override
  int get hashCode => onPhoneChanged.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is PersonalInformationStepActionOnPhoneChanged &&
      other.onPhoneChanged == onPhoneChanged;

  @override
  String toString() {
    return "PersonalInformationStepActionOnPhoneChanged.$onPhoneChanged";
  }
}

final class PersonalInformationStepActionOnNextButtonTapped<
  A extends String,
  B extends String,
  C extends String,
  D
>
    extends PersonalInformationStepAction<A, B, C, D> {
  PersonalInformationStepActionOnNextButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is PersonalInformationStepActionOnNextButtonTapped;

  @override
  String toString() {
    return "PersonalInformationStepActionOnNextButtonTapped()";
  }
}

extension PersonalInformationStepActionPath on PersonalInformationStepAction {
  static final onNameChanged =
      WritableKeyPath<PersonalInformationStepAction, String?>(
        get: (action) {
          if (action is PersonalInformationStepActionOnNameChanged) {
            return action.onNameChanged;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = PersonalInformationStepActionEnum.onNameChanged(
              propAction,
            );
          }
          return rootAction!;
        },
      );
  static final onEmailChanged =
      WritableKeyPath<PersonalInformationStepAction, String?>(
        get: (action) {
          if (action is PersonalInformationStepActionOnEmailChanged) {
            return action.onEmailChanged;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = PersonalInformationStepActionEnum.onEmailChanged(
              propAction,
            );
          }
          return rootAction!;
        },
      );
  static final onPhoneChanged =
      WritableKeyPath<PersonalInformationStepAction, String?>(
        get: (action) {
          if (action is PersonalInformationStepActionOnPhoneChanged) {
            return action.onPhoneChanged;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = PersonalInformationStepActionEnum.onPhoneChanged(
              propAction,
            );
          }
          return rootAction!;
        },
      );
  static final onNextButtonTapped = WritableKeyPath<
    PersonalInformationStepAction,
    PersonalInformationStepActionOnNextButtonTapped?
  >(
    get: (action) {
      if (action is PersonalInformationStepActionOnNextButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = PersonalInformationStepActionEnum.onNextButtonTapped();
      }
      return rootAction!;
    },
  );
}
