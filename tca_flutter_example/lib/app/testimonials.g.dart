// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonials.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension TestimonialsStatePath on TestimonialsState {
  static final destination = WritableKeyPath<
    TestimonialsState,
    Presents<TestimonialDestination<dynamic>>?
  >(
    get: (obj) => obj.destination,
    set: (obj, destination) => obj!.copyWith(destination: destination),
  );
  static final testimonials =
      KeyPath<TestimonialsState, Shared<List<Testimonial>>>(
        get: (obj) => obj.testimonials,
      );
}

mixin _$TestimonialsState {
  Presents<TestimonialDestination<dynamic>>? get destination;
  Shared<List<Testimonial>> get testimonials;
  TestimonialsState copyWith({
    Presents<TestimonialDestination<dynamic>>? destination,
  }) {
    return TestimonialsState(destination: destination ?? this.destination);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestimonialsState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(
            destination,
            other.destination,
          ) &&
          const DeepCollectionEquality().equals(
            testimonials,
            other.testimonials,
          );
  @override
  int get hashCode => Object.hash(runtimeType, destination, testimonials);
  @override
  String toString() {
    return "TestimonialsState(destination: $destination, testimonials: $testimonials)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension TestimonialDestinationEnum on TestimonialDestination {
  static TestimonialDestination testimonialComposition() =>
      TestimonialDestinationTestimonialComposition();
}

final class TestimonialDestinationTestimonialComposition<A>
    extends TestimonialDestination<A> {
  TestimonialDestinationTestimonialComposition() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialDestinationTestimonialComposition;

  @override
  String toString() {
    return "TestimonialDestinationTestimonialComposition()";
  }
}

extension TestimonialDestinationPath on TestimonialDestination {
  static final testimonialComposition = WritableKeyPath<
    TestimonialDestination,
    TestimonialDestinationTestimonialComposition?
  >(
    get: (action) {
      if (action is TestimonialDestinationTestimonialComposition) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = TestimonialDestinationEnum.testimonialComposition();
      }
      return rootAction!;
    },
  );
}

extension TestimonialsActionEnum on TestimonialsAction {
  static TestimonialsAction onWriteButtonTapped() =>
      TestimonialsActionOnWriteButtonTapped();
}

final class TestimonialsActionOnWriteButtonTapped<A>
    extends TestimonialsAction<A> {
  TestimonialsActionOnWriteButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialsActionOnWriteButtonTapped;

  @override
  String toString() {
    return "TestimonialsActionOnWriteButtonTapped()";
  }
}

extension TestimonialsActionPath on TestimonialsAction {
  static final onWriteButtonTapped = WritableKeyPath<
    TestimonialsAction,
    TestimonialsActionOnWriteButtonTapped?
  >(
    get: (action) {
      if (action is TestimonialsActionOnWriteButtonTapped) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = TestimonialsActionEnum.onWriteButtonTapped();
      }
      return rootAction!;
    },
  );
}
