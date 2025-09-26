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
  static final profile = WritableKeyPath<HomeState, ProfileState>(
    get: (obj) => obj.profile,
    set: (obj, profile) => obj!.copyWith(profile: profile),
  );
  static final selectedIndex = WritableKeyPath<HomeState, int>(
    get: (obj) => obj.selectedIndex,
    set: (obj, selectedIndex) => obj!.copyWith(selectedIndex: selectedIndex),
  );
}

mixin _$HomeState {
  FilesState get files;
  TestimonialsState get testimonials;
  ProfileState get profile;
  int get selectedIndex;
  HomeState copyWith({
    FilesState? files,
    TestimonialsState? testimonials,
    ProfileState? profile,
    int? selectedIndex,
  }) {
    return HomeState(
      files: files ?? this.files,
      testimonials: testimonials ?? this.testimonials,
      profile: profile ?? this.profile,
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
          const DeepCollectionEquality().equals(profile, other.profile) &&
          const DeepCollectionEquality().equals(
            selectedIndex,
            other.selectedIndex,
          );
  @override
  int get hashCode =>
      Object.hash(runtimeType, files, testimonials, profile, selectedIndex);
  @override
  String toString() {
    return "HomeState(files: $files, testimonials: $testimonials, profile: $profile, selectedIndex: $selectedIndex)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension HomeActionEnum on HomeAction {
  static HomeAction files(FilesAction<dynamic> p) => HomeActionFiles(p);
  static HomeAction testimonials(
    TestimonialsAction<dynamic, int, TestimonialComposeAction<String>> p,
  ) => HomeActionTestimonials(p);
  static HomeAction profile(ProfileAction p) => HomeActionProfile(p);
}

final class HomeActionFiles<
  A extends FilesAction<dynamic>,
  B extends TestimonialsAction<dynamic, int, TestimonialComposeAction<String>>,
  C extends ProfileAction
>
    extends HomeAction<A, B, C> {
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
  B extends TestimonialsAction<dynamic, int, TestimonialComposeAction<String>>,
  C extends ProfileAction
>
    extends HomeAction<A, B, C> {
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

final class HomeActionProfile<
  A extends FilesAction<dynamic>,
  B extends TestimonialsAction<dynamic, int, TestimonialComposeAction<String>>,
  C extends ProfileAction
>
    extends HomeAction<A, B, C> {
  final C profile;
  HomeActionProfile(this.profile) : super();

  @override
  int get hashCode => profile.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is HomeActionProfile && other.profile == profile;

  @override
  String toString() {
    return "HomeActionProfile.$profile";
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
    TestimonialsAction<dynamic, int, TestimonialComposeAction<String>>?
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
  static final profile = WritableKeyPath<HomeAction, ProfileAction?>(
    get: (action) {
      if (action is HomeActionProfile) {
        return action.profile;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = HomeActionEnum.profile(propAction);
      }
      return rootAction!;
    },
  );
}
