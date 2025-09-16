import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';

import 'clients/models/models.dart';

part 'testimonial_compose.g.dart';

typedef State = TestimonialComposeState;
typedef Action = TestimonialComposeAction;

@KeyPathable()
final class TestimonialComposeState with _$TestimonialComposeState {
  @override
  final Testimonial testimonial;

  TestimonialComposeState({required this.testimonial});
}

@CaseKeyPathable()
sealed class TestimonialComposeAction {}

final class TestimonialComposeFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce((state, action) {
      return Effect.none();
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
          appBar: AppBar(title: Text("...")),
          body: Center(child: Text(viewStore.state.testimonial.text)),
        );
      },
    );
  }
}
