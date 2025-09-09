// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension FilesStatePath on FilesState {
  static final files = KeyPath<FilesState, Shared<SharedFiles>>(
    get: (obj) => obj.files,
  );
}

mixin _$FilesState {
  Shared<SharedFiles> get files;

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

extension FilesActionEnum on FilesAction {
  static FilesAction onAddFileButtonTapped() =>
      FilesActionOnAddFileButtonTapped();
}

final class FilesActionOnAddFileButtonTapped<A> extends FilesAction<A> {
  FilesActionOnAddFileButtonTapped() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is FilesActionOnAddFileButtonTapped;

  @override
  String toString() {
    return "FilesActionOnAddFileButtonTapped()";
  }
}

extension FilesActionPath on FilesAction {
  static final onAddFileButtonTapped =
      WritableKeyPath<FilesAction, FilesActionOnAddFileButtonTapped?>(
        get: (action) {
          if (action is FilesActionOnAddFileButtonTapped) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = FilesActionEnum.onAddFileButtonTapped();
          }
          return rootAction!;
        },
      );
}
