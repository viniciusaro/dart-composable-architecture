import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import '../clients/models/models.dart';
import '../widgets/default_text_field.dart';

part 'testimonial_compose.g.dart';

typedef State = TestimonialComposeState;
typedef Action = TestimonialComposeAction;

@KeyPathable()
final class TestimonialComposeState with _$TestimonialComposeState {
  @override
  final Shared<Testimonial> testimonial;

  TestimonialComposeState({required this.testimonial});
}

@CaseKeyPathable()
sealed class TestimonialComposeAction<
  OnValueUpdate extends String //
> {}

final class TestimonialComposeFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce((state, action) {
      switch (action) {
        case TestimonialComposeActionOnValueUpdate():
          state.value.testimonial.set(
            (t) => t.copyWith(text: action.onValueUpdate),
          );
          return Effect.none();
      }
    });
  }
}

final class TestimonialComposeWidget extends StatelessWidget {
  final Store<State, Action> store;

  const TestimonialComposeWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
      store,
      body: (viewStore) {
        return Scaffold(
          appBar: AppBar(
            title: Text(viewStore.state.testimonial.value.preview),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: DefaultTextField(
              value: viewStore.state.testimonial.value.text,
              onChanged: (value) {
                viewStore.send(
                  TestimonialComposeActionEnum.onValueUpdate(value),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
