import 'package:composable_architecture/composable_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/realtime_counter_sync/clients/message_broker_client/message_broker_client.dart';
import 'package:tca_flutter_example/realtime_counter_sync/realtime_counter_sync.dart';

void main() {
  test("increment button tapped", () {
    messageBrokerClient = emptyMessageBrokerClient;
    final store = TestStore(initialState: AppState(), reducer: appReducer);
    store.send(
      AppActionEnum.counter(CounterActionEnum.incrementButtonTapped()),
      AppState(counter: CounterState(count: 1)),
    );
  });

  test("increment button tapped yields external message", () async {
    messageBrokerClient =
        unimplementedMessageBrokerClient
          ..listen =
              () => Stream.value(
                Message(action: "increment", deviceId: "id", id: "unique id"), //
              );

    final store = TestStore(initialState: AppState(), reducer: appReducer);
    store.send(AppActionOnInitState(), AppState());
    await store.receive(
      AppActionEnum.messageBroker(MessageBrokerActionEnum.incrementExternal()),
      AppState(counter: CounterState(count: 1)),
    );
  });
}
