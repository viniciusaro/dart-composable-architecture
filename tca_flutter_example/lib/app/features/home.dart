import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart' hide NavigationDestination;
import 'package:tca_flutter_example/app/features/profile.dart';

import '../widgets/default_tab_bar_view.dart';

import 'files.dart';
import 'testimonial_compose.dart';
import 'testimonials.dart';

part 'home.g.dart';

typedef State = HomeState;
typedef Action = HomeAction;

@KeyPathable()
final class HomeState with _$HomeState, Presentable {
  @override
  final FilesState files;

  @override
  final TestimonialsState testimonials;

  @override
  final ProfileState profile;

  @override
  final int selectedIndex;

  HomeState({
    FilesState? files,
    TestimonialsState? testimonials, //
    ProfileState? profile,
    this.selectedIndex = 1,
  }) : files = files ?? FilesState(),
       testimonials = testimonials ?? TestimonialsState(),
       profile = profile ?? ProfileState();
}

@CaseKeyPathable()
sealed class HomeAction<
  Files extends FilesAction,
  Testimonials extends TestimonialsAction,
  Profile extends ProfileAction
> {}

final class HomeFeature extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce.combine([
      Scope(
        state: HomeStatePath.files,
        action: HomeActionPath.files,
        reducer: FilesFeature(),
      ),
      Scope(
        state: HomeStatePath.testimonials,
        action: HomeActionPath.testimonials,
        reducer: TestimonialsFeature(),
      ),
      Scope(
        state: HomeStatePath.profile,
        action: HomeActionPath.profile,
        reducer: EmptyReducer(),
      ),
    ]);
  }
}

final class HomeWidget extends StatelessWidget {
  final Store<State, Action> store;

  const HomeWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore.identity(
      store,
      body: (viewStore) {
        final compositionStatePath = HomeStatePath
            .testimonials //
            .path(TestimonialsStatePath.destination)
            .path(TestimonialDestinationPath.testimonialCompose);

        final compositionActionPath = HomeActionPath
            .testimonials //
            .path(TestimonialsActionPath.testimonialCompose);

        final filesStore = viewStore.view(
          state: HomeStatePath.files,
          action: HomeActionPath.files,
        );

        final testimonialsStore = viewStore.view(
          state: HomeStatePath.testimonials,
          action: HomeActionPath.testimonials,
        );

        final profileStore = viewStore.view(
          state: HomeStatePath.profile,
          action: HomeActionPath.profile,
        );

        return NavigationDestination(
          viewStore.view(
            state: compositionStatePath,
            action: compositionActionPath, //
          ),
          builder: (context, store) {
            return TestimonialComposeWidget(store: store);
          },
          child: Scaffold(
            body: Row(
              children: [
                Flexible(child: FilesWidget(store: filesStore!)),
                Flexible(child: TestimonialsWidget(store: testimonialsStore!)),
                Flexible(child: ProfileWidget(store: profileStore!)),
              ],
            ),
          ),
        );
      },
    );
  }
}
