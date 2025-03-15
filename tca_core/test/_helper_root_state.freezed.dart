// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_helper_root_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RootState {
  CounterState get counter;
  FavoritesState get favorites;

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
            (identical(other.counter, counter) || other.counter == counter) &&
            (identical(other.favorites, favorites) ||
                other.favorites == favorites));
  }

  @override
  int get hashCode => Object.hash(runtimeType, counter, favorites);

  @override
  String toString() {
    return 'RootState(counter: $counter, favorites: $favorites)';
  }
}

/// @nodoc
abstract mixin class $RootStateCopyWith<$Res> {
  factory $RootStateCopyWith(RootState value, $Res Function(RootState) _then) =
      _$RootStateCopyWithImpl;
  @useResult
  $Res call({CounterState? counter, FavoritesState? favorites});
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
    Object? counter = freezed,
    Object? favorites = freezed,
  }) {
    return _then(RootState(
      counter: freezed == counter
          ? _self.counter!
          : counter // ignore: cast_nullable_to_non_nullable
              as CounterState?,
      favorites: freezed == favorites
          ? _self.favorites!
          : favorites // ignore: cast_nullable_to_non_nullable
              as FavoritesState?,
    ));
  }
}

/// @nodoc
mixin _$CounterState {
  int get count;

  /// Create a copy of CounterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CounterStateCopyWith<CounterState> get copyWith =>
      _$CounterStateCopyWithImpl<CounterState>(
          this as CounterState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CounterState &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  @override
  String toString() {
    return 'CounterState(count: $count)';
  }
}

/// @nodoc
abstract mixin class $CounterStateCopyWith<$Res> {
  factory $CounterStateCopyWith(
          CounterState value, $Res Function(CounterState) _then) =
      _$CounterStateCopyWithImpl;
  @useResult
  $Res call({int count});
}

/// @nodoc
class _$CounterStateCopyWithImpl<$Res> implements $CounterStateCopyWith<$Res> {
  _$CounterStateCopyWithImpl(this._self, this._then);

  final CounterState _self;
  final $Res Function(CounterState) _then;

  /// Create a copy of CounterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
  }) {
    return _then(CounterState(
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$FavoritesState {
  List<int> get favorites;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FavoritesStateCopyWith<FavoritesState> get copyWith =>
      _$FavoritesStateCopyWithImpl<FavoritesState>(
          this as FavoritesState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FavoritesState &&
            const DeepCollectionEquality().equals(other.favorites, favorites));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(favorites));

  @override
  String toString() {
    return 'FavoritesState(favorites: $favorites)';
  }
}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res> {
  factory $FavoritesStateCopyWith(
          FavoritesState value, $Res Function(FavoritesState) _then) =
      _$FavoritesStateCopyWithImpl;
  @useResult
  $Res call({List<int> favorites});
}

/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
  }) {
    return _then(FavoritesState(
      favorites: null == favorites
          ? _self.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
