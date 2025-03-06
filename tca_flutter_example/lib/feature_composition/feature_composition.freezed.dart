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

/// @nodoc
mixin _$CounterState {

 int get count; Set<int> get favorites;
/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CounterStateCopyWith<CounterState> get copyWith => _$CounterStateCopyWithImpl<CounterState>(this as CounterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterState&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.favorites, favorites));
}


@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(favorites));

@override
String toString() {
  return 'CounterState(count: $count, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $CounterStateCopyWith<$Res>  {
  factory $CounterStateCopyWith(CounterState value, $Res Function(CounterState) _then) = _$CounterStateCopyWithImpl;
@useResult
$Res call({
 int count, Set<int> favorites
});




}
/// @nodoc
class _$CounterStateCopyWithImpl<$Res>
    implements $CounterStateCopyWith<$Res> {
  _$CounterStateCopyWithImpl(this._self, this._then);

  final CounterState _self;
  final $Res Function(CounterState) _then;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? favorites = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// @nodoc


class _CounterState implements CounterState {
  const _CounterState({this.count = 0, final  Set<int> favorites = const {}}): _favorites = favorites;
  

@override@JsonKey() final  int count;
 final  Set<int> _favorites;
@override@JsonKey() Set<int> get favorites {
  if (_favorites is EqualUnmodifiableSetView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_favorites);
}


/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CounterStateCopyWith<_CounterState> get copyWith => __$CounterStateCopyWithImpl<_CounterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CounterState&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'CounterState(count: $count, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class _$CounterStateCopyWith<$Res> implements $CounterStateCopyWith<$Res> {
  factory _$CounterStateCopyWith(_CounterState value, $Res Function(_CounterState) _then) = __$CounterStateCopyWithImpl;
@override @useResult
$Res call({
 int count, Set<int> favorites
});




}
/// @nodoc
class __$CounterStateCopyWithImpl<$Res>
    implements _$CounterStateCopyWith<$Res> {
  __$CounterStateCopyWithImpl(this._self, this._then);

  final _CounterState _self;
  final $Res Function(_CounterState) _then;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? favorites = null,}) {
  return _then(_CounterState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,favorites: null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

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
