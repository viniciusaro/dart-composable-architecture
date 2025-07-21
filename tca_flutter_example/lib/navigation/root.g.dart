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

mixin _$RootState {
  AppState get app;
  RootState copyWith({AppState? app}) {
    return RootState(app: app ?? this.app);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RootState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(app, other.app);
  @override
  int get hashCode => Object.hash(runtimeType, app);
  @override
  String toString() {
    return "RootState(app: $app)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension RootActionEnum on RootAction {
  static RootAction app(AppAction<Item, EditAction<Item>> p) =>
      RootActionApp(p);
}

final class RootActionApp<A extends AppAction<Item, EditAction<Item>>>
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
      WritableKeyPath<RootAction, AppAction<Item, EditAction<Item>>?>(
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
