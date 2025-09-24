// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension MembersStatePath on MembersState {
  static final members = KeyPath<MembersState, Shared<List<List<Member>>>>(
    get: (obj) => obj.members,
  );
}

mixin _$MembersState {
  Shared<List<List<Member>>> get members;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembersState &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(members, other.members);
  @override
  int get hashCode => Object.hash(runtimeType, members);
  @override
  String toString() {
    return "MembersState(members: $members)";
  }
}

// **************************************************************************
// CaseKeyPathGenerator
// **************************************************************************

extension MembersActionEnum on MembersAction {}

extension MembersActionPath on MembersAction {}
