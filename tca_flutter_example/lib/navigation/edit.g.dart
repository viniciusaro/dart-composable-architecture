// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension EditStatePath on EditState {
  static final item = WritableKeyPath<EditState, Item>(
    get: (obj) => obj.item,
    set: (obj, item) => obj!.copyWith(item: item),
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension EditActionEnum on EditAction {
  static EditAction onEditCancelled() => EditActionOnEditCancelled();
  static EditAction onEditComplete(Item p) => EditActionOnEditComplete(p);
}

final class EditActionOnEditCancelled<A, B extends Item>
    extends EditAction<A, B> {
  EditActionOnEditCancelled() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is EditActionOnEditCancelled;

  @override
  String toString() {
    return "EditActionOnEditCancelled()";
  }
}

final class EditActionOnEditComplete<A, B extends Item>
    extends EditAction<A, B> {
  final B onEditComplete;
  EditActionOnEditComplete(this.onEditComplete) : super();

  @override
  int get hashCode => onEditComplete.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is EditActionOnEditComplete &&
      other.onEditComplete == onEditComplete;

  @override
  String toString() {
    return "EditActionOnEditComplete.$onEditComplete";
  }
}

extension EditActionPath on EditAction {
  static final onEditCancelled =
      WritableKeyPath<EditAction, EditActionOnEditCancelled?>(
        get: (action) {
          if (action is EditActionOnEditCancelled) {
            return action;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = EditActionEnum.onEditCancelled();
          }
          return rootAction!;
        },
      );
  static final onEditComplete = WritableKeyPath<EditAction, Item?>(
    get: (action) {
      if (action is EditActionOnEditComplete) {
        return action.onEditComplete;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = EditActionEnum.onEditComplete(propAction);
      }
      return rootAction!;
    },
  );
}
