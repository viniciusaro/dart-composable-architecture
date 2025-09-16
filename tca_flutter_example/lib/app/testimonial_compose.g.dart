// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonial_compose.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension TestimonialComposeStatePath on TestimonialComposeState {
  static final testimonial =
      WritableKeyPath<TestimonialComposeState, Testimonial>(
        get: (obj) => obj.testimonial,
        set: (obj, testimonial) => obj!.copyWith(testimonial: testimonial),
      );
}

mixin _$TestimonialComposeState {
  Testimonial get testimonial;
  TestimonialComposeState copyWith({Testimonial? testimonial}) {
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

extension TestimonialComposeActionEnum on TestimonialComposeAction {}

extension TestimonialComposeActionPath on TestimonialComposeAction {}
