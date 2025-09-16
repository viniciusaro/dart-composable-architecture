// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonials.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension TestimonialsStatePath on TestimonialsState {
  static final destination = WritableKeyPath<
    TestimonialsState,
    Presents<TestimonialDestination<TestimonialComposeState>?>
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
  Presents<TestimonialDestination<TestimonialComposeState>?> get destination;
  Shared<List<Testimonial>> get testimonials;
  TestimonialsState copyWith({
    Presents<TestimonialDestination<TestimonialComposeState>?>? destination,
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
  static TestimonialDestination testimonialComposition(
    TestimonialComposeState p,
  ) => TestimonialDestinationTestimonialComposition(p);
}

final class TestimonialDestinationTestimonialComposition<
  A extends TestimonialComposeState
>
    extends TestimonialDestination<A> {
  final A testimonialComposition;
  TestimonialDestinationTestimonialComposition(this.testimonialComposition)
    : super();

  @override
  int get hashCode => testimonialComposition.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialDestinationTestimonialComposition &&
      other.testimonialComposition == testimonialComposition;

  @override
  String toString() {
    return "TestimonialDestinationTestimonialComposition.$testimonialComposition";
  }
}

extension TestimonialDestinationPath on TestimonialDestination {
  static final testimonialComposition =
      WritableKeyPath<TestimonialDestination, TestimonialComposeState?>(
        get: (action) {
          if (action is TestimonialDestinationTestimonialComposition) {
            return action.testimonialComposition;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = TestimonialDestinationEnum.testimonialComposition(
              propAction,
            );
          }
          return rootAction!;
        },
      );
}

extension TestimonialsActionEnum on TestimonialsAction {
  static TestimonialsAction onWriteButtonTapped() =>
      TestimonialsActionOnWriteButtonTapped();
  static TestimonialsAction onEditButtonTapped(int p) =>
      TestimonialsActionOnEditButtonTapped(p);
  static TestimonialsAction testimonialComposition(
    TestimonialComposeAction<String, dynamic> p,
  ) => TestimonialsActionTestimonialComposition(p);
}

final class TestimonialsActionOnWriteButtonTapped<
  A,
  B extends int,
  C extends TestimonialComposeAction<String, dynamic>
>
    extends TestimonialsAction<A, B, C> {
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

final class TestimonialsActionOnEditButtonTapped<
  A,
  B extends int,
  C extends TestimonialComposeAction<String, dynamic>
>
    extends TestimonialsAction<A, B, C> {
  final B onEditButtonTapped;
  TestimonialsActionOnEditButtonTapped(this.onEditButtonTapped) : super();

  @override
  int get hashCode => onEditButtonTapped.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialsActionOnEditButtonTapped &&
      other.onEditButtonTapped == onEditButtonTapped;

  @override
  String toString() {
    return "TestimonialsActionOnEditButtonTapped.$onEditButtonTapped";
  }
}

final class TestimonialsActionTestimonialComposition<
  A,
  B extends int,
  C extends TestimonialComposeAction<String, dynamic>
>
    extends TestimonialsAction<A, B, C> {
  final C testimonialComposition;
  TestimonialsActionTestimonialComposition(this.testimonialComposition)
    : super();

  @override
  int get hashCode => testimonialComposition.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialsActionTestimonialComposition &&
      other.testimonialComposition == testimonialComposition;

  @override
  String toString() {
    return "TestimonialsActionTestimonialComposition.$testimonialComposition";
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
  static final onEditButtonTapped = WritableKeyPath<TestimonialsAction, int?>(
    get: (action) {
      if (action is TestimonialsActionOnEditButtonTapped) {
        return action.onEditButtonTapped;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = TestimonialsActionEnum.onEditButtonTapped(propAction);
      }
      return rootAction!;
    },
  );
  static final testimonialComposition = WritableKeyPath<
    TestimonialsAction,
    TestimonialComposeAction<String, dynamic>?
  >(
    get: (action) {
      if (action is TestimonialsActionTestimonialComposition) {
        return action.testimonialComposition;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = TestimonialsActionEnum.testimonialComposition(propAction);
      }
      return rootAction!;
    },
  );
}
