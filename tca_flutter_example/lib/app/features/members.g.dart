// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members.dart';

// **************************************************************************
// KeyPathGenerator
// **************************************************************************

extension MembersStatePath on MembersState {
  static final members = KeyPath<MembersState, Shared<List<Member>>>(
    get: (obj) => obj.members,
  );
}

mixin _$MembersState {
  Shared<List<Member>> get members;

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

extension MembersActionEnum on MembersAction {
  static MembersAction onStart() => MembersActionOnStart();
  static MembersAction memberListUpdate(SharedAction<List<Member>> p) =>
      MembersActionMemberListUpdate(p);
}

final class MembersActionOnStart<A, B extends SharedAction<List<Member>>>
    extends MembersAction<A, B> {
  MembersActionOnStart() : super();

  @override
  int get hashCode => runtimeType.hashCode ^ 31;

  @override
  bool operator ==(Object other) => other is MembersActionOnStart;

  @override
  String toString() {
    return "MembersActionOnStart()";
  }
}

final class MembersActionMemberListUpdate<
  A,
  B extends SharedAction<List<Member>>
>
    extends MembersAction<A, B> {
  final B memberListUpdate;
  MembersActionMemberListUpdate(this.memberListUpdate) : super();

  @override
  int get hashCode => memberListUpdate.hashCode ^ 31;

  @override
  bool operator ==(Object other) =>
      other is MembersActionMemberListUpdate &&
      other.memberListUpdate == memberListUpdate;

  @override
  String toString() {
    return "MembersActionMemberListUpdate.$memberListUpdate";
  }
}

extension MembersActionPath on MembersAction {
  static final onStart = WritableKeyPath<MembersAction, MembersActionOnStart?>(
    get: (action) {
      if (action is MembersActionOnStart) {
        return action;
      }
      return null;
    },
    set: (rootAction, propAction) {
      if (propAction != null) {
        rootAction = MembersActionEnum.onStart();
      }
      return rootAction!;
    },
  );
  static final memberListUpdate =
      WritableKeyPath<MembersAction, SharedAction<List<Member>>?>(
        get: (action) {
          if (action is MembersActionMemberListUpdate) {
            return action.memberListUpdate;
          }
          return null;
        },
        set: (rootAction, propAction) {
          if (propAction != null) {
            rootAction = MembersActionEnum.memberListUpdate(propAction);
          }
          return rootAction!;
        },
      );
}

extension MembersActionSharedListeners on MembersAction {
  Effect<MembersActionMemberListUpdate> Function(Shared<List<Member>>)
  get memberListUpdate {
    return (shared) => Effect.stream(
      () => shared
          .listen()
          .map(SharedAction.new)
          .map(MembersActionMemberListUpdate.new),
    );
  }
}
