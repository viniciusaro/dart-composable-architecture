import 'dart:math';

import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart' hide NavigationDestination;
import 'package:tca_flutter_example/app/clients/models/models.fixtures.dart';
import 'package:tca_flutter_example/app/testimonial_compose.dart';
import 'clients/models/models.dart';
import 'shared.extensions.dart';

part 'testimonials.g.dart';

@KeyPathable()
final class TestimonialsState with _$TestimonialsState, Presentable {
  @override
  final Presents<TestimonialDestination?> destination;

  @override
  final testimonials = SharedX.userPrefs(<Testimonial>[]);

  TestimonialsState({
    Presents<TestimonialDestination?>? destination, //
  }) : destination = destination ?? Presents(null);
}

@CaseKeyPathable()
sealed class TestimonialDestination<
  TestimonialComposition extends TestimonialComposeState //
> {}

@CaseKeyPathable()
sealed class TestimonialsAction<
  OnWriteButtonTapped,
  TestimonialComposition extends TestimonialComposeAction
> {}

final class TestimonialsFeature
    extends Feature<TestimonialsState, TestimonialsAction> {
  @override
  Reducer<TestimonialsState, TestimonialsAction> build() {
    return Reduce((state, action) {
      switch (action) {
        case TestimonialsActionOnWriteButtonTapped():
          state.mutate(
            (s) => s.copyWith(
              destination: Presents(
                TestimonialDestinationEnum.testimonialComposition(
                  TestimonialComposeState(testimonial: draft()),
                ),
              ),
            ),
          );
          return Effect.none();
        case TestimonialsActionTestimonialComposition():
          return Effect.none();
      }
    });
  }
}

final class TestimonialsWidget extends StatelessWidget {
  final Store<TestimonialsState, TestimonialsAction> store;

  const TestimonialsWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final compositionDestinationPath = TestimonialsStatePath
        .destination //
        .path(TestimonialDestinationPath.testimonialComposition);

    return WithViewStore(
      store,
      body: (viewStore) {
        return NavigationDestination(
          viewStore.view(
            state: compositionDestinationPath,
            action: TestimonialsActionPath.testimonialComposition,
          ),
          builder: (context, store) {
            return TestimonialComposeWidget(store: store);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Testimonials"),
              actions: [
                IconButton(
                  onPressed: () {
                    viewStore.send(
                      TestimonialsActionEnum.onWriteButtonTapped(),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: viewStore.state.testimonials.value.length,
              itemBuilder: (context, index) {
                final testimonial = viewStore.state.testimonials.value[index];
                return ListTile(
                  title: Text(
                    testimonial.text.substring(
                      0,
                      min(20, testimonial.text.length - 1),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
