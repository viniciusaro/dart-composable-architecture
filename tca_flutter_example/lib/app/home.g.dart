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
}

mixin _$HomeState {
  FilesState get files;
  HomeState copyWith({FilesState? files}) {
    return HomeState(files: files ?? this.files);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(files, other.files);
  @override
  int get hashCode => Object.hash(runtimeType, files);
  @override
  String toString() {
    return "HomeState(files: $files)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension HomeActionEnum on HomeAction {
  static HomeAction files(FilesAction<dynamic> p) => HomeActionFiles(p);
}

final class HomeActionFiles<A extends FilesAction<dynamic>>
    extends HomeAction<A> {
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
}
