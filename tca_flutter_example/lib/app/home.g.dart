// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension HomeStatePath on HomeState {
  static final files = WritableKeyPath<HomeState, FilesState>(
    get: (obj) => obj.files,
    set: (obj, files) => obj!.copyWith(files: files),
  );
  static final testimonials = WritableKeyPath<HomeState, TestimonialsState>(
    get: (obj) => obj.testimonials,
    set: (obj, testimonials) => obj!.copyWith(testimonials: testimonials),
  );
  static final selectedIndex = WritableKeyPath<HomeState, int>(
    get: (obj) => obj.selectedIndex,
    set: (obj, selectedIndex) => obj!.copyWith(selectedIndex: selectedIndex),
  );
}

mixin _$HomeState {
  FilesState get files;
  TestimonialsState get testimonials;
  int get selectedIndex;
  HomeState copyWith({
    FilesState? files,
    TestimonialsState? testimonials,
    int? selectedIndex,
  }) {
    return HomeState(
      files: files ?? this.files,
      testimonials: testimonials ?? this.testimonials,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(files, other.files) &&
          const DeepCollectionEquality().equals(
            testimonials,
            other.testimonials,
          ) &&
          const DeepCollectionEquality().equals(
            selectedIndex,
            other.selectedIndex,
          );
  @override
  int get hashCode =>
      Object.hash(runtimeType, files, testimonials, selectedIndex);
  @override
  String toString() {
    return "HomeState(files: $files, testimonials: $testimonials, selectedIndex: $selectedIndex)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension HomeActionEnum on HomeAction {
  static HomeAction files(FilesAction<dynamic> p) => HomeActionFiles(p);
  static HomeAction testimonials(
    TestimonialsAction<dynamic, int, TestimonialComposeAction<String, dynamic>>
    p,
  ) => HomeActionTestimonials(p);
}

final class HomeActionFiles<
  A extends FilesAction<dynamic>,
  B extends TestimonialsAction<
    dynamic,
    int,
    TestimonialComposeAction<String, dynamic>
  >
>
    extends HomeAction<A, B> {
  final A files;
  HomeActionFiles(this.files) : super();

  @override
  int get hashCode => files.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is HomeActionFiles && other.files == files;

  @override
  String toString() {
    return "HomeActionFiles.$files";
  }
}

final class HomeActionTestimonials<
  A extends FilesAction<dynamic>,
  B extends TestimonialsAction<
    dynamic,
    int,
    TestimonialComposeAction<String, dynamic>
  >
>
    extends HomeAction<A, B> {
  final B testimonials;
  HomeActionTestimonials(this.testimonials) : super();

  @override
  int get hashCode => testimonials.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is HomeActionTestimonials && other.testimonials == testimonials;

  @override
  String toString() {
    return "HomeActionTestimonials.$testimonials";
  }
}

extension HomeActionPath on HomeAction {
  static final files = WritableKeyPath<HomeAction, FilesAction<dynamic>?>(
    get: (action) {
      if (action is HomeActionFiles) {
        return action.files;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = HomeActionEnum.files(propAction);
      }
      return rootAction!;
    },
  );
  static final testimonials = WritableKeyPath<
    HomeAction,
    TestimonialsAction<dynamic, int, TestimonialComposeAction<String, dynamic>>?
  >(
    get: (action) {
      if (action is HomeActionTestimonials) {
        return action.testimonials;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = HomeActionEnum.testimonials(propAction);
      }
      return rootAction!;
    },
  );
}
