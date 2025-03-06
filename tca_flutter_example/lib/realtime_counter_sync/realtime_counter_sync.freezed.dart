// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_counter_sync.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 CounterState get counter;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode => Object.hash(runtimeType,counter);

@override
String toString() {
  return 'AppState(counter: $counter)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 CounterState counter
});


$CounterStateCopyWith<$Res> get counter;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? counter = null,}) {
  return _then(_self.copyWith(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as CounterState,
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
}
}


/// @nodoc


class _AppState implements AppState {
   _AppState({this.counter = const CounterState()});
  

@override@JsonKey() final  CounterState counter;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode => Object.hash(runtimeType,counter);

@override
String toString() {
  return 'AppState(counter: $counter)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 CounterState counter
});


@override $CounterStateCopyWith<$Res> get counter;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? counter = null,}) {
  return _then(_AppState(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as CounterState,
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
}
}

/// @nodoc
mixin _$CounterState {

 int get count;
/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CounterStateCopyWith<CounterState> get copyWith => _$CounterStateCopyWithImpl<CounterState>(this as CounterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterState&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'CounterState(count: $count)';
}


}

/// @nodoc
abstract mixin class $CounterStateCopyWith<$Res>  {
  factory $CounterStateCopyWith(CounterState value, $Res Function(CounterState) _then) = _$CounterStateCopyWithImpl;
@useResult
$Res call({
 int count
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
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _CounterState implements CounterState {
  const _CounterState({this.count = 0});
  

@override@JsonKey() final  int count;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CounterStateCopyWith<_CounterState> get copyWith => __$CounterStateCopyWithImpl<_CounterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CounterState&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'CounterState(count: $count)';
}


}

/// @nodoc
abstract mixin class _$CounterStateCopyWith<$Res> implements $CounterStateCopyWith<$Res> {
  factory _$CounterStateCopyWith(_CounterState value, $Res Function(_CounterState) _then) = __$CounterStateCopyWithImpl;
@override @useResult
$Res call({
 int count
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
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_CounterState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
