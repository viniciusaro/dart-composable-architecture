/// Markup type for states that contain [Presents] properties.
///
/// This type allows custom overloads for `view` method on [Store], that will
/// automatically clean up state when navigation ends.
///
/// Every state that contain a property marked with `Presents` should
/// conform to this mixin.
mixin Presentable {}

/// Markup type for properties that represent data related to dynamically
/// presenting state.
///
/// This type allows custom overloads for KeyPaths that behave different than usual.
///
/// For instance, supose the following application domain:
///
/// ```dart
/// @CaseKeyPathable()
/// sealed class AppDestination<
///   Edit extends EditState //
/// > {}
///
/// @freezed
/// @KeyPathable()
/// final class AppState with _$AppState, Presentable {
///   @override
///   final Presents<AppDestination?> destination;
///   AppState({this.destination = const Presents(null)});
/// }
///
/// @freezed
/// @KeyPathable()
/// final class EditState with _$EditState {
///   @override
///   final String item;
///   EditState({required this.item});
/// }
/// ```
///
/// When constructing a keypath to show the edit feature, one would write:
///
/// ```dart
/// store.view(
///   state: AppStatePath.destination.path(AppDestinationPath.edit)),
///   action: AppActionPath.edit,
/// );
///
/// The state KeyPath passed as parameter allows reading and writing to the
/// `edit` property.
///
/// However, it would be really usefull if we could automatically write to the
/// `destination` property on AppState, for example when the navigation ends,
/// we could write null to it.
///
/// The [Presents] type allows just that, it allows writing a custom `path` function
/// on KeyPath that runs specificaly for Presents types. This custom implementation
/// writes null to the parent property if the child property is null, allowing
/// automatic update of state when the [NavigationDestination] type removes the
/// associated route from the navigation stack.
/// ```
final class Presents<T> {
  final T value;
  const Presents(this.value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is Presents<T> && other.value == value;
  }

  @override
  String toString() {
    return "Presents($value)";
  }
}
