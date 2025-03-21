// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension AppStatePath on AppState {
  static final items = WritableKeyPath<AppState, List<Item>>(
    get: (obj) => obj.items,
    set: (obj, items) => obj!.copyWith(items: items),
  );
  static final destination =
      WritableKeyPath<AppState, Presents<AppDestination<EditState>?>>(
        get: (obj) => obj.destination,
        set: (obj, destination) => obj!.copyWith(destination: destination),
      );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension AppDestinationEnum on AppDestination {
  static AppDestination edit(EditState p) => AppDestinationEdit(p);
}

final class AppDestinationEdit<A extends EditState> extends AppDestination<A> {
  final A edit;
  AppDestinationEdit(this.edit) : super();

  @override
  int get hashCode => edit.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppDestinationEdit && other.edit == edit;

  @override
  String toString() {
    return "AppDestinationEdit.$edit";
  }
}

extension AppDestinationPath on AppDestination {
  static final edit = WritableKeyPath<AppDestination, EditState?>(
    get: (action) {
      if (action is AppDestinationEdit) {
        return action.edit;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppDestinationEnum.edit(propAction);
      }
      return rootAction!;
    },
  );
}

extension AppActionEnum on AppAction {
  static AppAction editItemButtonTapped(Item p) =>
      AppActionEditItemButtonTapped(p);
  static AppAction edit(EditAction<dynamic, Item> p) => AppActionEdit(p);
}

final class AppActionEditItemButtonTapped<
  A extends Item,
  B extends EditAction<dynamic, Item>
>
    extends AppAction<A, B> {
  final A editItemButtonTapped;
  AppActionEditItemButtonTapped(this.editItemButtonTapped) : super();

  @override
  int get hashCode => editItemButtonTapped.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionEditItemButtonTapped &&
      other.editItemButtonTapped == editItemButtonTapped;

  @override
  String toString() {
    return "AppActionEditItemButtonTapped.$editItemButtonTapped";
  }
}

final class AppActionEdit<A extends Item, B extends EditAction<dynamic, Item>>
    extends AppAction<A, B> {
  final B edit;
  AppActionEdit(this.edit) : super();

  @override
  int get hashCode => edit.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is AppActionEdit && other.edit == edit;

  @override
  String toString() {
    return "AppActionEdit.$edit";
  }
}

extension AppActionPath on AppAction {
  static final editItemButtonTapped = WritableKeyPath<AppAction, Item?>(
    get: (action) {
      if (action is AppActionEditItemButtonTapped) {
        return action.editItemButtonTapped;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.editItemButtonTapped(propAction);
      }
      return rootAction!;
    },
  );
  static final edit = WritableKeyPath<AppAction, EditAction<dynamic, Item>?>(
    get: (action) {
      if (action is AppActionEdit) {
        return action.edit;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = AppActionEnum.edit(propAction);
      }
      return rootAction!;
    },
  );
}
