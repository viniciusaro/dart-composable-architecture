// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_fact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NumberFactState {

 int get count; bool get isLoading; String? get numberFact;
/// Create a copy of NumberFactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberFactStateCopyWith<NumberFactState> get copyWith => _$NumberFactStateCopyWithImpl<NumberFactState>(this as NumberFactState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberFactState&&(identical(other.count, count) || other.count == count)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.numberFact, numberFact) || other.numberFact == numberFact));
}


@override
int get hashCode => Object.hash(runtimeType,count,isLoading,numberFact);

@override
String toString() {
  return 'NumberFactState(count: $count, isLoading: $isLoading, numberFact: $numberFact)';
}


}

/// @nodoc
abstract mixin class $NumberFactStateCopyWith<$Res>  {
  factory $NumberFactStateCopyWith(NumberFactState value, $Res Function(NumberFactState) _then) = _$NumberFactStateCopyWithImpl;
@useResult
$Res call({
 int count, bool isLoading, String? numberFact
});




}
/// @nodoc
class _$NumberFactStateCopyWithImpl<$Res>
    implements $NumberFactStateCopyWith<$Res> {
  _$NumberFactStateCopyWithImpl(this._self, this._then);

  final NumberFactState _self;
  final $Res Function(NumberFactState) _then;

/// Create a copy of NumberFactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? isLoading = null,Object? numberFact = freezed,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,numberFact: freezed == numberFact ? _self.numberFact : numberFact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _NumberFactState implements NumberFactState {
   _NumberFactState({this.count = 0, this.isLoading = false, this.numberFact});
  

@override@JsonKey() final  int count;
@override@JsonKey() final  bool isLoading;
@override final  String? numberFact;

/// Create a copy of NumberFactState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberFactStateCopyWith<_NumberFactState> get copyWith => __$NumberFactStateCopyWithImpl<_NumberFactState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberFactState&&(identical(other.count, count) || other.count == count)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.numberFact, numberFact) || other.numberFact == numberFact));
}


@override
int get hashCode => Object.hash(runtimeType,count,isLoading,numberFact);

@override
String toString() {
  return 'NumberFactState(count: $count, isLoading: $isLoading, numberFact: $numberFact)';
}


}

/// @nodoc
abstract mixin class _$NumberFactStateCopyWith<$Res> implements $NumberFactStateCopyWith<$Res> {
  factory _$NumberFactStateCopyWith(_NumberFactState value, $Res Function(_NumberFactState) _then) = __$NumberFactStateCopyWithImpl;
@override @useResult
$Res call({
 int count, bool isLoading, String? numberFact
});




}
/// @nodoc
class __$NumberFactStateCopyWithImpl<$Res>
    implements _$NumberFactStateCopyWith<$Res> {
  __$NumberFactStateCopyWithImpl(this._self, this._then);

  final _NumberFactState _self;
  final $Res Function(_NumberFactState) _then;

/// Create a copy of NumberFactState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? isLoading = null,Object? numberFact = freezed,}) {
  return _then(_NumberFactState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,numberFact: freezed == numberFact ? _self.numberFact : numberFact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
