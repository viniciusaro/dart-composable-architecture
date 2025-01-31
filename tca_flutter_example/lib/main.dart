import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FeatureWidget(store: Store(initialState: FeatureState(), reducer: featureReducer)),
      ),
    ),
  );
}

@KeyPathable()
final class FeatureState {
  int count = 0;
  bool isLoading = false;
  String? numberFact;
}

@CaseKeyPathable()
final class FeatureAction<
  DecrementButtonTapped,
  IncrementButtonTapped,
  NumberFactButtonTapped,
  NumberFactResponse extends NumberFactResponseValue //
> {}

final class NumberFactResponseValue {
  final String value;
  NumberFactResponseValue(this.value);
}

Effect<FeatureAction> featureReducer(Inout<FeatureState> state, FeatureAction action) {
  switch (action) {
    case FeatureActionDecrementButtonTapped():
      state.mutate((s) => s..count -= 1);
      return Effect.none();

    case FeatureActionIncrementButtonTapped():
      state.mutate((s) => s..count += 1);
      return Effect.none();

    case FeatureActionNumberFactButtonTapped():
      state.mutate((s) => s..isLoading = true);
      return Effect.future(() async {
        final uri = Uri.parse("http://numbersapi.com/${state.value.count}/trivia");
        final response = await http.get(uri);
        return FeatureAction.numberFactResponse(NumberFactResponseValue(response.body));
      });

    case FeatureActionNumberFactResponse():
      state.mutate((s) {
        return s
          ..isLoading = false
          ..numberFact = action.numberFactResponse.value;
      });
      return Effect.none();
  }
  throw Exception("invalid action");
}

final class FeatureReducer<State, Action> {}

class FeatureWidget extends StatelessWidget {
  final Store<FeatureState, FeatureAction> store;

  const FeatureWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore<FeatureState, FeatureAction>(
      store,
      body: (viewStore) {
        return Center(
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Count: ${viewStore.state.count}"),
              ElevatedButton(
                onPressed: () => viewStore.send(FeatureAction.numberFactButtonTapped()),
                child: Text("Number Fact"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => viewStore.send(FeatureAction.incrementButtonTapped()),
                    child: Text("+"),
                  ),
                  ElevatedButton(
                    onPressed: () => viewStore.send(FeatureAction.decrementButtonTapped()),
                    child: Text("-"),
                  ),
                ],
              ),
              if (viewStore.state.isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: CircularProgressIndicator(),
                )
              else if (viewStore.state.numberFact != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text("Fact: ${viewStore.state.numberFact}", textAlign: TextAlign.center),
                ),
            ],
          ),
        );
      },
    );
  }
}
