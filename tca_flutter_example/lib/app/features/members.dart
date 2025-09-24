import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:tca_flutter_example/app/clients/models/models.dart';
import 'package:tca_flutter_example/app/extensions/shared.extensions.dart';

part 'members.g.dart';

@KeyPathable()
final class MembersState with _$MembersState {
  @override
  final members = SharedX.userPrefs(<List<Member>>[]);
}

@CaseKeyPathable()
sealed class MembersAction {}
