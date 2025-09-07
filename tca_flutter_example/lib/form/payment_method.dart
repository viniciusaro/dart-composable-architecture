import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

part 'payment_method_data.dart';
part 'payment_method.g.dart';

typedef State = PaymentMethodStepState;
typedef Action = PaymentMethodStepAction;

enum PaymentMethod {
  card,
  bankTransfer, //
}

@KeyPathable()
final class PaymentMethodStepState with _$PaymentMethodStepState {
  @override
  final data = Shared.inMemory(PaymentMethodData());
}

@CaseKeyPathable()
sealed class PaymentMethodStepAction<
  OnPaymentMethodChanged extends PaymentMethod, //
  OnNextButtonTapped
> {}

final class PaymentMethodStepFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce((state, action) {
      switch (action) {
        case PaymentMethodStepActionOnPaymentMethodChanged():
          state.value.data.set(
            (d) => d.copyWith(paymentMethod: action.onPaymentMethodChanged),
          );
          return Effect.none();
        case PaymentMethodStepActionOnNextButtonTapped():
          return Effect.none();
      }
    });
  }
}

final class PaymentMethodStepWidget extends StatelessWidget {
  final Store<PaymentMethodStepState, PaymentMethodStepAction> store;

  const PaymentMethodStepWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Payment Method'),
              RadioListTile(
                value: PaymentMethod.card,
                title: Text('Card'),
                groupValue: viewStore.state.data.value.paymentMethod,
                onChanged: (value) {
                  if (value == null) return;
                  viewStore.send(
                    PaymentMethodStepActionEnum.onPaymentMethodChanged(value),
                  );
                },
              ),
              const SizedBox(height: 16),
              RadioListTile(
                value: PaymentMethod.bankTransfer,
                title: Text('Bank Transfer'),
                groupValue: viewStore.state.data.value.paymentMethod,
                onChanged: (value) {
                  if (value == null) return;
                  viewStore.send(
                    PaymentMethodStepActionEnum.onPaymentMethodChanged(value),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  viewStore.send(
                    PaymentMethodStepActionEnum.onNextButtonTapped(),
                  );
                },
                child: Text('Next'),
              ),
            ],
          ),
        );
      },
    );
  }
}
