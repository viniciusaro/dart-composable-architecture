// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_composition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 CounterState get counter; FavoritesState get favorites;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.counter, counter) || other.counter == counter)&&(identical(other.favorites, favorites) || other.favorites == favorites));
}


@override
int get hashCode => Object.hash(runtimeType,counter,favorites);

@override
String toString() {
  return 'AppState(counter: $counter, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 CounterState counter, FavoritesState favorites
});


$CounterStateCopyWith<$Res> get counter;$FavoritesStateCopyWith<$Res> get favorites;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? counter = null,Object? favorites = null,}) {
  return _then(_self.copyWith(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as CounterState,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as FavoritesState,
  ));
}
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CounterStateCopyWith<$Res> get counter {
  
  return $CounterStateCopyWith<$Res>(_self.counter, (value) {
    return _then(_self.copyWith(counter: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<$Res> get favorites {
  
  return $FavoritesStateCopyWith<$Res>(_self.favorites, (value) {
    return _then(_self.copyWith(favorites: value));
  });
}
}


/// @nodoc


class _AppState implements AppState {
  const _AppState({this.counter = const CounterState(), this.favorites = const FavoritesState()});
  

@override@JsonKey() final  CounterState counter;
@override@JsonKey() final  FavoritesState favorites;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.counter, counter) || other.counter == counter)&&(identical(other.favorites, favorites) || other.favorites == favorites));
}


@override
int get hashCode => Object.hash(runtimeType,counter,favorites);

@override
String toString() {
  return 'AppState(counter: $counter, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 CounterState counter, FavoritesState favorites
});


@override $CounterStateCopyWith<$Res> get counter;@override $FavoritesStateCopyWith<$Res> get favorites;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? counter = null,Object? favorites = null,}) {
  return _then(_AppState(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as CounterState,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as FavoritesState,
  ));
}

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CounterStateCopyWith<$Res> get counter {
  
  return $CounterStateCopyWith<$Res>(_self.counter, (value) {
    return _then(_self.copyWith(counter: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<$Res> get favorites {
  
  return $FavoritesStateCopyWith<$Res>(_self.favorites, (value) {
    return _then(_self.copyWith(favorites: value));
  });
}
}

// dart format on
