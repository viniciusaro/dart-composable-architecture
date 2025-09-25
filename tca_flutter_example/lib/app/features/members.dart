import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:tca_flutter_example/app/clients/models/models.dart';
import 'package:tca_flutter_example/app/extensions/shared.extensions.dart';

part 'members.g.dart';

typedef State = MembersState;
typedef Action = MembersAction;

@KeyPathable()
final class MembersState with _$MembersState {
  @override
  final members = Shared.x.userPrefs(<Member>[]);
}

@CaseKeyPathable()
sealed class MembersAction<
  OnStart,
  MemberListUpdate extends SharedAction<List<Member>> //
> {}

final class MembersFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce((state, action) {
      switch (action) {
        case MembersActionOnStart():
          return action.memberListUpdate(state.value.members);
        case MembersActionMemberListUpdate():
          state.value.members.set((_) => action.memberListUpdate.value);
          return Effect.none();
      }
    });
  }
}
