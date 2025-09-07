import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'success.g.dart';

typedef State = SuccessStepState;
typedef Action = SuccessStepAction;

@KeyPathable()
final class SuccessStepState with _$SuccessStepState {
  @override
  final String description;
  SuccessStepState({required this.description});
}

@CaseKeyPathable()
sealed class SuccessStepAction<
  OnSuccessButtonTapped //
> {}

final class SuccessStepFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce((state, action) {
      return Effect.none();
    });
  }
}

final class SuccessStepWidget extends StatelessWidget {
  final Store<SuccessStepState, SuccessStepAction> store;

  const SuccessStepWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Success'),
              Text(viewStore.state.description.toString()),
              ElevatedButton(
                onPressed: () {
                  viewStore.send(SuccessStepActionEnum.onSuccessButtonTapped());
                },
                child: Text('Back to form'),
              ),
            ],
          ),
        );
      },
    );
  }
}
