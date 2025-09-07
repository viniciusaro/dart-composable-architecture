// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension FilesStatePath on FilesState {
  static final files = WritableKeyPath<FilesState, List<SharedFile>>(
    get: (obj) => obj.files,
    set: (obj, files) => obj!.copyWith(files: files),
  );
}

mixin _$FilesState {
  List<SharedFile> get files;
  FilesState copyWith({List<SharedFile>? files}) {
    return FilesState(files: files ?? this.files);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilesState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(files, other.files);
  @override
  int get hashCode => Object.hash(runtimeType, files);
  @override
  String toString() {
    return "FilesState(files: $files)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension FilesActionEnum on FilesAction {}

extension FilesActionPath on FilesAction {}
