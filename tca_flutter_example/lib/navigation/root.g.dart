// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension RootStatePath on RootState {
  static final app = WritableKeyPath<RootState, AppState>(
    get: (obj) => obj.app,
    set: (obj, app) => obj!.copyWith(app: app),
  );
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension RootActionEnum on RootAction {
  static RootAction app(AppAction<Item, EditAction<dynamic, Item>> p) =>
      RootActionApp(p);
}

final class RootActionApp<A extends AppAction<Item, EditAction<dynamic, Item>>>
    extends RootAction<A> {
  final A app;
  RootActionApp(this.app) : super();

  @override
  int get hashCode => app.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is RootActionApp && other.app == app;

  @override
  String toString() {
    return "RootActionApp.$app";
  }
}

extension RootActionPath on RootAction {
  static final app =
      WritableKeyPath<RootAction, AppAction<Item, EditAction<dynamic, Item>>?>(
        get: (action) {
          if (action is RootActionApp) {
            return action.app;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = RootActionEnum.app(propAction);
          }
          return rootAction!;
        },
      );
}
