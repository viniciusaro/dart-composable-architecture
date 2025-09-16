// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonial_compose.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension TestimonialComposeStatePath on TestimonialComposeState {
  static final testimonial =
      WritableKeyPath<TestimonialComposeState, Shared<Testimonial>>(
        get: (obj) => obj.testimonial,
        set: (obj, testimonial) => obj!.copyWith(testimonial: testimonial),
      );
}

mixin _$TestimonialComposeState {
  Shared<Testimonial> get testimonial;
  TestimonialComposeState copyWith({Shared<Testimonial>? testimonial}) {
    return TestimonialComposeState(
      testimonial: testimonial ?? this.testimonial,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestimonialComposeState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(testimonial, other.testimonial);
  @override
  int get hashCode => Object.hash(runtimeType, testimonial);
  @override
  String toString() {
    return "TestimonialComposeState(testimonial: $testimonial)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension TestimonialComposeActionEnum on TestimonialComposeAction {
  static TestimonialComposeAction onValueUpdate(String p) =>
      TestimonialComposeActionOnValueUpdate(p);
  static TestimonialComposeAction onSaveButtonTapped() =>
      TestimonialComposeActionOnSaveButtonTapped();
}

final class TestimonialComposeActionOnValueUpdate<A extends String, B>
    extends TestimonialComposeAction<A, B> {
  final A onValueUpdate;
  TestimonialComposeActionOnValueUpdate(this.onValueUpdate) : super();

  @override
  int get hashCode => onValueUpdate.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialComposeActionOnValueUpdate &&
      other.onValueUpdate == onValueUpdate;

  @override
  String toString() {
    return "TestimonialComposeActionOnValueUpdate.$onValueUpdate";
  }
}

final class TestimonialComposeActionOnSaveButtonTapped<A extends String, B>
    extends TestimonialComposeAction<A, B> {
  TestimonialComposeActionOnSaveButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialComposeActionOnSaveButtonTapped;

  @override
  String toString() {
    return "TestimonialComposeActionOnSaveButtonTapped()";
  }
}

extension TestimonialComposeActionPath on TestimonialComposeAction {
  static final onValueUpdate =
      WritableKeyPath<TestimonialComposeAction, String?>(
        get: (action) {
          if (action is TestimonialComposeActionOnValueUpdate) {
            return action.onValueUpdate;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = TestimonialComposeActionEnum.onValueUpdate(propAction);
          }
          return rootAction!;
        },
      );
  static final onSaveButtonTapped = WritableKeyPath<
    TestimonialComposeAction,
    TestimonialComposeActionOnSaveButtonTapped?
  >(
    get: (action) {
      if (action is TestimonialComposeActionOnSaveButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = TestimonialComposeActionEnum.onSaveButtonTapped();
      }
      return rootAction!;
    },
  );
}
