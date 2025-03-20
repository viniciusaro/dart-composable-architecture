// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditState {

 Item get item;
/// Create a copy of EditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditStateCopyWith<EditState> get copyWith => _$EditStateCopyWithImpl<EditState>(this as EditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditState&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'EditState(item: $item)';
}


}

/// @nodoc
abstract mixin class $EditStateCopyWith<$Res>  {
  factory $EditStateCopyWith(EditState value, $Res Function(EditState) _then) = _$EditStateCopyWithImpl;
@useResult
$Res call({
 Item item
});




}
/// @nodoc
class _$EditStateCopyWithImpl<$Res>
    implements $EditStateCopyWith<$Res> {
  _$EditStateCopyWithImpl(this._self, this._then);

  final EditState _self;
  final $Res Function(EditState) _then;

/// Create a copy of EditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,}) {
  return _then(EditState(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as Item,
  ));
}

}


// dart format on
