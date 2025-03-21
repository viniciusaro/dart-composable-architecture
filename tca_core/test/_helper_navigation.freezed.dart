// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_helper_navigation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RootState {
  AppState get app;

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RootStateCopyWith<RootState> get copyWith =>
      _$RootStateCopyWithImpl<RootState>(this as RootState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RootState &&
            (identical(other.app, app) || other.app == app));
  }

  @override
  int get hashCode => Object.hash(runtimeType, app);

  @override
  String toString() {
    return 'RootState(app: $app)';
  }
}

/// @nodoc
abstract mixin class $RootStateCopyWith<$Res> {
  factory $RootStateCopyWith(RootState value, $Res Function(RootState) _then) =
      _$RootStateCopyWithImpl;
  @useResult
  $Res call({AppState app});
}

/// @nodoc
class _$RootStateCopyWithImpl<$Res> implements $RootStateCopyWith<$Res> {
  _$RootStateCopyWithImpl(this._self, this._then);

  final RootState _self;
  final $Res Function(RootState) _then;

  /// Create a copy of RootState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
  }) {
    return _then(RootState(
      app: null == app
          ? _self.app
          : app // ignore: cast_nullable_to_non_nullable
              as AppState,
    ));
  }
}

/// @nodoc
mixin _$AppState {
  Presents<AppDestination?> get destination;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppStateCopyWith<AppState> get copyWith =>
      _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppState &&
            (identical(other.destination, destination) ||
                other.destination == destination));
  }

  @override
  int get hashCode => Object.hash(runtimeType, destination);

  @override
  String toString() {
    return 'AppState(destination: $destination)';
  }
}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) =
      _$AppStateCopyWithImpl;
  @useResult
  $Res call({Presents<AppDestination<DetailState>?> destination});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
  }) {
    return _then(AppState(
      destination: null == destination
          ? _self.destination!
          : destination // ignore: cast_nullable_to_non_nullable
              as Presents<AppDestination<DetailState>?>,
    ));
  }
}

/// @nodoc
mixin _$DetailState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DetailState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DetailState()';
  }
}

/// @nodoc
class $DetailStateCopyWith<$Res> {
  $DetailStateCopyWith(DetailState _, $Res Function(DetailState) __);
}

// dart format on
