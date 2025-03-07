// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesState {

 Set<int> get favorites;
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<FavoritesState> get copyWith => _$FavoritesStateCopyWithImpl<FavoritesState>(this as FavoritesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState&&const DeepCollectionEquality().equals(other.favorites, favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(favorites));

@override
String toString() {
  return 'FavoritesState(favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res>  {
  factory $FavoritesStateCopyWith(FavoritesState value, $Res Function(FavoritesState) _then) = _$FavoritesStateCopyWithImpl;
@useResult
$Res call({
 Set<int> favorites
});




}
/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favorites = null,}) {
  return _then(_self.copyWith(
favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// @nodoc


class _FavoritesState implements FavoritesState {
  const _FavoritesState({final  Set<int> favorites = const {}}): _favorites = favorites;
  

 final  Set<int> _favorites;
@override@JsonKey() Set<int> get favorites {
  if (_favorites is EqualUnmodifiableSetView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_favorites);
}


/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesStateCopyWith<_FavoritesState> get copyWith => __$FavoritesStateCopyWithImpl<_FavoritesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesState&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'FavoritesState(favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class _$FavoritesStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory _$FavoritesStateCopyWith(_FavoritesState value, $Res Function(_FavoritesState) _then) = __$FavoritesStateCopyWithImpl;
@override @useResult
$Res call({
 Set<int> favorites
});




}
/// @nodoc
class __$FavoritesStateCopyWithImpl<$Res>
    implements _$FavoritesStateCopyWith<$Res> {
  __$FavoritesStateCopyWithImpl(this._self, this._then);

  final _FavoritesState _self;
  final $Res Function(_FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favorites = null,}) {
  return _then(_FavoritesState(
favorites: null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

// dart format on
