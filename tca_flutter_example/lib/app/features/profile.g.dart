// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension ProfileStatePath on ProfileState {
  static final files = KeyPath<ProfileState, Shared<List<SharedFile>>>(
    get: (obj) => obj.files,
  );
  static final testimonials = KeyPath<ProfileState, Shared<List<Testimonial>>>(
    get: (obj) => obj.testimonials,
  );
}

mixin _$ProfileState {
  Shared<List<SharedFile>> get files;
  Shared<List<Testimonial>> get testimonials;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(files, other.files) &&
          const DeepCollectionEquality().equals(
            testimonials,
            other.testimonials,
          );
  @override
  int get hashCode => Object.hash(runtimeType, files, testimonials);
  @override
  String toString() {
    return "ProfileState(files: $files, testimonials: $testimonials)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension ProfileActionEnum on ProfileAction {}

extension ProfileActionPath on ProfileAction {}
