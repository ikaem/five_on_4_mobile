import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen_view.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/provider/get_my_today_matches_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/provider/load_my_matches_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/matches_controller_state_value.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  final getMyTodayMatchesUseCase = _MockGetMyTodayMatchesUseCase();
  final loadMyMatchesUseCase = _MockLoadMyMatchesUseCase();

  tearDown(() {
    reset(getMyTodayMatchesUseCase);
    reset(loadMyMatchesUseCase);
  });

  group(
    "$HomeScreenView",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show [CurrentUserGreeting] with expected arguments passed to it",
            (widgetTester) async {
              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async => [],
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {},
              );

              await widgetTester.pumpWidget(
                ProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  child: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                ),
              );

              final userGreetingFinder = find.byWidgetPredicate((widget) {
                if (widget is! HomeGreeting) return false;
                // TODO there will be more tests here

                return true;
              });

              expect(userGreetingFinder, findsOneWidget);
            },
          );
          // TODO need to test the controller changing state will render toggler differently -

// TODO come back to this
        },
      );

      group(
        "State Reactivity",
        () {
          testWidgets(
            "given $GetMyMatchesController is in loading state"
            "when widget is rendered"
            "should show [TabToggler] widget with expected arguments passed to it",
            (widgetTester) async {
              final matchesToday =
                  getTestMatchesModels(count: 2, namesPrefix: "today_");
              // final matchesUpcoming =
              //     getTestMatchesModels(count: 10, namesPrefix: "following_");

              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async => matchesToday,
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {},
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  ProviderScope(
                    overrides: [
                      getMyTodayMatchesUseCaseProvider.overrideWith(
                        (ref) => getMyTodayMatchesUseCase,
                      ),
                      loadMyMatchesUseCaseProvider.overrideWith(
                        (ref) => loadMyMatchesUseCase,
                      ),
                    ],
                    child: const MaterialApp(
                      home: Scaffold(
                        body: HomeScreenView(),
                      ),
                    ),
                  ),
                );
              });

              // initial state of the controller is loading - we tested that

              final tabTogglerFinder = find.byWidgetPredicate((widget) {
                if (widget is! TabToggler) return false;
                if (widget.options.length != 2) return false;

                final option1 = widget.options[0];
                final option2 = widget.options[1];

                final option1Title = option1.title;
                final option2Title = option2.title;

                // TODO this should be tested with something else - possibly in layout group
                // if (option1Title != "Today") return false;
                // if (option2Title != "Following") return false;

                final option1Child = option1.child;
                final option2Child = option2.child;

                if (option1Child is! HomeEventsContainer) return false;
                if (option2Child is! HomeEventsContainer) return false;

                if (!option1Child.isLoading) return false;
                if (!option2Child.isLoading) return false;

                // if (option1Child.isToday != true) return false;
                // if (option2Child.isToday != false) return false;

                // if (option1Child.matches != matchesToday) return false;
                // // TODO temp still
                // if (option2Child.matches != []) return false;

                return true;
              });

              expect(tabTogglerFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

class _FakeMatchesStateValue extends Fake
    implements MatchesControllerStateValue {}

class _MockGetMyTodayMatchesUseCase extends Mock
    implements GetMyTodayMatchesUseCase {}

class _MockLoadMyMatchesUseCase extends Mock implements LoadMyMatchesUseCase {}
