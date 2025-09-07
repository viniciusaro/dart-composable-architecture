// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension SuccessStepStatePath on SuccessStepState {
  static final description = WritableKeyPath<SuccessStepState, String>(
    get: (obj) => obj.description,
    set: (obj, description) => obj!.copyWith(description: description),
  );
}

mixin _$SuccessStepState {
  String get description;
  SuccessStepState copyWith({String? description}) {
    return SuccessStepState(description: description ?? this.description);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuccessStepState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(description, other.description);
  @override
  int get hashCode => Object.hash(runtimeType, description);
  @override
  String toString() {
    return "SuccessStepState(description: $description)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension SuccessStepActionEnum on SuccessStepAction {
  static SuccessStepAction onSuccessButtonTapped() =>
      SuccessStepActionOnSuccessButtonTapped();
}

final class SuccessStepActionOnSuccessButtonTapped<A>
    extends SuccessStepAction<A> {
  SuccessStepActionOnSuccessButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is SuccessStepActionOnSuccessButtonTapped;

  @override
  String toString() {
    return "SuccessStepActionOnSuccessButtonTapped()";
  }
}

extension SuccessStepActionPath on SuccessStepAction {
  static final onSuccessButtonTapped = WritableKeyPath<
    SuccessStepAction,
    SuccessStepActionOnSuccessButtonTapped?
  >(
    get: (action) {
      if (action is SuccessStepActionOnSuccessButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = SuccessStepActionEnum.onSuccessButtonTapped();
      }
      return rootAction!;
    },
  );
}
