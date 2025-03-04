import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/number_fact/number_fact.dart';
import 'package:tca_flutter_example/number_fact/number_fact_client.dart';

void main() {
  test('decrement button tapped', () {
    final store = TestStore(initialState: NumberFactState(), reducer: numberFactReducer);
    store.send(
      NumberFactActionEnum.decrementButtonTapped(),
      NumberFactState(count: -1), //
    );
  });

  test('increment button tapped', () {
    final store = TestStore(initialState: NumberFactState(), reducer: numberFactReducer);
    store.send(
      NumberFactActionEnum.incrementButtonTapped(),
      NumberFactState(count: 1), //
    );
  });

  test('number fact button tapped', () async {
    numberFactClient = NumberFactClient(factFor: (n) async => "$n is a good number");
    final store = TestStore(initialState: NumberFactState(), reducer: numberFactReducer);

    store.send(
      NumberFactActionEnum.numberFactButtonTapped(),
      NumberFactState(isLoading: true), //
    );

    await store.receive(
      NumberFactActionEnum.numberFactResponse("0 is a good number"),
      NumberFactState(isLoading: false, numberFact: "0 is a good number"),
    );
  });
}
