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

mixin _$EditState {
  Item get item;
  EditState copyWith({Item? item}) {
    return EditState(item: item ?? this.item);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(item, other.item);
  @override
  int get hashCode => Object.hash(runtimeType, item);
  @override
  String toString() {
    return "EditState(item: $item)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension EditActionEnum on EditAction {
  static EditAction onEditComplete(Item p) => EditActionOnEditComplete(p);
}

final class EditActionOnEditComplete<A extends Item> extends EditAction<A> {
  final A onEditComplete;
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
