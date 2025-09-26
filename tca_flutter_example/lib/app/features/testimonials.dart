import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart' hide NavigationDestination;

import '../clients/models/models.dart';
import '../clients/models/models.fixtures.dart';
import '../extensions/shared.extensions.dart';

import 'testimonial_compose.dart';

part 'testimonials.g.dart';

typedef State = TestimonialsState;
typedef Action = TestimonialsAction;

@KeyPathable()
final class TestimonialsState with _$TestimonialsState, Presentable {
  @override
  final Presents<TestimonialDestination?> destination;

  @override
  final testimonials = Shared.x.userPrefs(<Testimonial>[]);

  TestimonialsState({
    Presents<TestimonialDestination?>? destination, //
  }) : destination = destination ?? Presents(null);
}

@CaseKeyPathable()
sealed class TestimonialDestination<
  TestimonialCompose extends TestimonialComposeState //
> {}

@CaseKeyPathable()
sealed class TestimonialsAction<
  OnWriteButtonTapped,
  OnEditButtonTapped extends int,
  TestimonialCompose extends TestimonialComposeAction
> {}

final class TestimonialsFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    final compositionPath = TestimonialsStatePath
        .destination //
        .path(TestimonialDestinationPath.testimonialCompose);

    return Reduce.combine([
      IfLet(
        state: compositionPath,
        action: TestimonialsActionPath.testimonialCompose,
        reducer: TestimonialComposeFeature(), //
      ),
      Reduce((state, action) {
        switch (action) {
          case TestimonialsActionOnWriteButtonTapped():
            state.value.testimonials.set((list) => [draft(), ...list]);

            state.mutate(
              (s) => s.copyWith(
                destination: Presents(
                  TestimonialDestinationEnum.testimonialCompose(
                    TestimonialComposeState(
                      testimonial: state.value.testimonials.get(listPath(0)),
                    ),
                  ),
                ),
              ),
            );
            return Effect.none();
          case TestimonialsActionOnEditButtonTapped():
            state.mutate(
              (s) => s.copyWith(
                destination: Presents(
                  TestimonialDestinationEnum.testimonialCompose(
                    TestimonialComposeState(
                      testimonial: state.value.testimonials.get(
                        listPath(action.onEditButtonTapped),
                      ),
                    ),
                  ),
                ),
              ),
            );
            return Effect.none();
          case TestimonialsActionTestimonialCompose():
            return Effect.none();
        }
      }),
    ]);
  }
}

final class TestimonialsWidget extends StatelessWidget {
  final Store<TestimonialsState, TestimonialsAction> store;

  const TestimonialsWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore.identity(
      store,
      body: (viewStore) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Testimonials"),
            actions: [
              IconButton(
                onPressed: () {
                  viewStore.send(TestimonialsActionEnum.onWriteButtonTapped());
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
                title: Text(testimonial.preview),
                onTap: () {
                  viewStore.send(
                    TestimonialsActionEnum.onEditButtonTapped(index),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
