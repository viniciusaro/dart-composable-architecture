import 'package:composable_architecture/composable_architecture.dart';
import 'package:http/http.dart' as http;

@KeyPathable()
final class FeatureState {
  int count = 0;
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
      return Effect.future(() {
        final uri = Uri.parse("http://numbersapi.com/${state.value.count})/trivia");
        return http.post(uri).then(
              (response) => FeatureAction.numberFactResponse(
                NumberFactResponseValue(response.body),
              ),
            );
      });

    case FeatureActionNumberFactResponse():
      state.mutate((s) => s..numberFact = action.numberFactResponse.value);
      return Effect.none();
  }
  throw Exception("invalid action");
}
