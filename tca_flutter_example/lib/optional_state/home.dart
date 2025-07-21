import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'home.g.dart';

@KeyPathable()
final class HomeState with _$HomeState {}

@CaseKeyPathable()
sealed class HomeAction<
  OnSignOutButtonTapped //
> {}

final class HomeFeature extends Feature<HomeState, HomeAction> {
  @override
  Reducer<HomeState, HomeAction> build() {
    return EmptyReducer();
  }
}

class HomeWidget extends StatelessWidget {
  final Store<HomeState, HomeAction> store;

  const HomeWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: WithViewStore(
        store,
        body: (viewStore) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text("Welcome!"),
                ElevatedButton(
                  onPressed: () {
                    viewStore.send(HomeActionEnum.onSignOutButtonTapped());
                  },
                  child: Text("Sign out"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
