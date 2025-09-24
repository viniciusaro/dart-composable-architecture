import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';
import 'package:flutter/material.dart' hide NavigationDestination;

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
  final int selectedIndex;

  HomeState({
    FilesState? files,
    TestimonialsState? testimonials, //
    this.selectedIndex = 1,
  }) : files = files ?? FilesState(),
       testimonials = testimonials ?? TestimonialsState();
}

@CaseKeyPathable()
sealed class HomeAction<
  Files extends FilesAction,
  Testimonials extends TestimonialsAction
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
    ]);
  }
}

final class HomeWidget extends StatelessWidget {
  final Store<State, Action> store;

  const HomeWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return WithViewStore(
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

        return NavigationDestination(
          viewStore.view(
            state: compositionStatePath,
            action: compositionActionPath, //
          ),
          builder: (context, store) {
            return TestimonialComposeWidget(store: store);
          },
          child: DefaultTabBarView(
            selectedIndex: viewStore.state.selectedIndex,
            children: [
              FilesWidget(store: filesStore!),
              TestimonialsWidget(store: testimonialsStore!),
            ],
            builder: (context, child) {
              return Scaffold(
                body: child,
                bottomNavigationBar: const Material(
                  child: SafeArea(
                    child: DefaultTabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.home),
                          text: "Arquivos", //
                        ), //
                        Tab(
                          icon: Icon(Icons.menu_book_rounded),
                          text: "Testimonials",
                        ), //
                      ],
                    ),
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
