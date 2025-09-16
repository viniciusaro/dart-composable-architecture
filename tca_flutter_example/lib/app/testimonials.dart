import 'dart:math';

import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart';
import 'clients/models/models.dart';
import 'shared.extensions.dart';

part 'testimonials.g.dart';

@CaseKeyPathable()
sealed class TestimonialDestination<
  TestimonialComposition //
> {}

@KeyPathable()
final class TestimonialsState with _$TestimonialsState {
  @override
  final Presents<TestimonialDestination>? destination;

  @override
  final testimonials = SharedX.userPrefs(<Testimonial>[]);

  TestimonialsState({this.destination});
}

@CaseKeyPathable()
sealed class TestimonialsAction<
  OnWriteButtonTapped //
> {}

final class TestimonialsFeature
    extends Feature<TestimonialsState, TestimonialsAction> {
  @override
  Reducer<TestimonialsState, TestimonialsAction> build() {
    return Reduce((state, action) {
      return Effect.none();
    });
  }
}

final class TestimonialsWidget extends StatelessWidget {
  final Store<TestimonialsState, TestimonialsAction> store;

  const TestimonialsWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
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
                title: Text(
                  testimonial.text.substring(
                    0,
                    min(20, testimonial.text.length - 1),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
