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
  static TestimonialDestination testimonialCompose(TestimonialComposeState p) =>
      TestimonialDestinationTestimonialCompose(p);
}

final class TestimonialDestinationTestimonialCompose<
  A extends TestimonialComposeState
>
    extends TestimonialDestination<A> {
  final A testimonialCompose;
  TestimonialDestinationTestimonialCompose(this.testimonialCompose) : super();

  @override
  int get hashCode => testimonialCompose.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialDestinationTestimonialCompose &&
      other.testimonialCompose == testimonialCompose;

  @override
  String toString() {
    return "TestimonialDestinationTestimonialCompose.$testimonialCompose";
  }
}

extension TestimonialDestinationPath on TestimonialDestination {
  static final testimonialCompose =
      WritableKeyPath<TestimonialDestination, TestimonialComposeState?>(
        get: (action) {
          if (action is TestimonialDestinationTestimonialCompose) {
            return action.testimonialCompose;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = TestimonialDestinationEnum.testimonialCompose(
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
  static TestimonialsAction testimonialCompose(
    TestimonialComposeAction<String> p,
  ) => TestimonialsActionTestimonialCompose(p);
}

final class TestimonialsActionOnWriteButtonTapped<
  A,
  B extends int,
  C extends TestimonialComposeAction<String>
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
  C extends TestimonialComposeAction<String>
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

final class TestimonialsActionTestimonialCompose<
  A,
  B extends int,
  C extends TestimonialComposeAction<String>
>
    extends TestimonialsAction<A, B, C> {
  final C testimonialCompose;
  TestimonialsActionTestimonialCompose(this.testimonialCompose) : super();

  @override
  int get hashCode => testimonialCompose.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is TestimonialsActionTestimonialCompose &&
      other.testimonialCompose == testimonialCompose;

  @override
  String toString() {
    return "TestimonialsActionTestimonialCompose.$testimonialCompose";
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
  static final testimonialCompose =
      WritableKeyPath<TestimonialsAction, TestimonialComposeAction<String>?>(
        get: (action) {
          if (action is TestimonialsActionTestimonialCompose) {
            return action.testimonialCompose;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = TestimonialsActionEnum.testimonialCompose(propAction);
          }
          return rootAction!;
        },
      );
}
