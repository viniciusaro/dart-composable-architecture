// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_helper_shared_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedState {
  SharedCounterState get counterA;
  SharedCounterState get counterB;
  int get nonSharedCounter;

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharedStateCopyWith<SharedState> get copyWith =>
      _$SharedStateCopyWithImpl<SharedState>(this as SharedState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharedState &&
            (identical(other.counterA, counterA) ||
                other.counterA == counterA) &&
            (identical(other.counterB, counterB) ||
                other.counterB == counterB) &&
            (identical(other.nonSharedCounter, nonSharedCounter) ||
                other.nonSharedCounter == nonSharedCounter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, counterA, counterB, nonSharedCounter);

  @override
  String toString() {
    return 'SharedState(counterA: $counterA, counterB: $counterB, nonSharedCounter: $nonSharedCounter)';
  }
}

/// @nodoc
abstract mixin class $SharedStateCopyWith<$Res> {
  factory $SharedStateCopyWith(
          SharedState value, $Res Function(SharedState) _then) =
      _$SharedStateCopyWithImpl;
  @useResult
  $Res call(
      {SharedCounterState? counterA,
      SharedCounterState? counterB,
      int nonSharedCounter});
}

/// @nodoc
class _$SharedStateCopyWithImpl<$Res> implements $SharedStateCopyWith<$Res> {
  _$SharedStateCopyWithImpl(this._self, this._then);

  final SharedState _self;
  final $Res Function(SharedState) _then;

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counterA = freezed,
    Object? counterB = freezed,
    Object? nonSharedCounter = null,
  }) {
    return _then(SharedState(
      counterA: freezed == counterA
          ? _self.counterA!
          : counterA // ignore: cast_nullable_to_non_nullable
              as SharedCounterState?,
      counterB: freezed == counterB
          ? _self.counterB!
          : counterB // ignore: cast_nullable_to_non_nullable
              as SharedCounterState?,
      nonSharedCounter: null == nonSharedCounter
          ? _self.nonSharedCounter
          : nonSharedCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SharedCounterState {
  Shared<int> get count;

  /// Create a copy of SharedCounterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharedCounterStateCopyWith<SharedCounterState> get copyWith =>
      _$SharedCounterStateCopyWithImpl<SharedCounterState>(
          this as SharedCounterState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharedCounterState &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  @override
  String toString() {
    return 'SharedCounterState(count: $count)';
  }
}

/// @nodoc
abstract mixin class $SharedCounterStateCopyWith<$Res> {
  factory $SharedCounterStateCopyWith(
          SharedCounterState value, $Res Function(SharedCounterState) _then) =
      _$SharedCounterStateCopyWithImpl;
  @useResult
  $Res call({Shared<int>? count});
}

/// @nodoc
class _$SharedCounterStateCopyWithImpl<$Res>
    implements $SharedCounterStateCopyWith<$Res> {
  _$SharedCounterStateCopyWithImpl(this._self, this._then);

  final SharedCounterState _self;
  final $Res Function(SharedCounterState) _then;

  /// Create a copy of SharedCounterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
  }) {
    return _then(SharedCounterState(
      count: freezed == count
          ? _self.count!
          : count // ignore: cast_nullable_to_non_nullable
              as Shared<int>?,
    ));
  }
}

// dart format on
