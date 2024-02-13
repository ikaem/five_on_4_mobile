import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen_view.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/get_my_today_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_my_today_matches/provider/get_my_today_matches_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/load_my_matches_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_my_matches/provider/load_my_matches_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/matches_controller_state_value.dart';
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

              await mockNetworkImages(() async {
                await widgetTester.pumpWithProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  widget: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                );
              });

              final userGreetingFinder = find.byWidgetPredicate((widget) {
                if (widget is! HomeGreeting) return false;
                // TODO there will be more tests here

                return true;
              });

              expect(userGreetingFinder, findsOneWidget);
            },
          );
          // TODO test that tab toggler is called with expected options
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show [TabToggler] with expected arguments passed to it",
            (widgetTester) async {
              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async => [],
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {},
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWithProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  widget: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                );
              });

              final tabTogglerFinder = _findTabToggler();

              expect(tabTogglerFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        "State Reactivity",
        () {
          // TODO need test for error
          testWidgets(
            "given GetMyMatchesController is in loading state"
            "when widget is rendered"
            "should show [TabToggler] widget with expected arguments passed to it",
            (widgetTester) async {
              final matchesToday =
                  getTestMatchesModels(count: 2, namesPrefix: "today_");

              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async => matchesToday,
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {},
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWithProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  widget: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                );
              });

              final tabTogglerFinder = _findTabToggler(
                propertyChecker: ({
                  required HomeEventsContainer todayContainerChild,
                  required HomeEventsContainer upcomingContainerChild,
                }) {
                  if (!todayContainerChild.isLoading) return false;
                  if (!upcomingContainerChild.isLoading) return false;

                  return true;
                },
              );

              expect(tabTogglerFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given GetMyMatchesController emits Data state with 'isRemoteFetchDone' set to false "
            "when widget is rendered"
            "should show [TabToggler] widget with expected arguments passed to it",
            (widgetTester) async {
              final matchesToday =
                  getTestMatchesModels(count: 2, namesPrefix: "today_");

              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async {
                  return matchesToday;
                },
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {
                  // simulate loading from server
                  await Future.delayed(Duration.zero);
                },
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWithProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  widget: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                );
              });

              // wait for the first data state to rebuild
              await widgetTester.pump();

              final tabTogglerFinder = _findTabToggler(
                propertyChecker: ({
                  required HomeEventsContainer todayContainerChild,
                  required HomeEventsContainer upcomingContainerChild,
                }) {
                  if (!todayContainerChild.isSyncing) return false;
                  if (!upcomingContainerChild.isSyncing) return false;

                  return true;
                },
              );

              expect(tabTogglerFinder, findsOneWidget);

              // allow for the load from server future to finish
              // TODO find better way for this
              await widgetTester.pumpAndSettle();
            },
          );

          testWidgets(
            "given GetMyMatchesController emits Data state with 'isRemoteFetchDone' set to true "
            "when widget is rendered"
            "should show [TabToggler] widget with expected arguments passed to it",
            (widgetTester) async {
              final matchesToday =
                  getTestMatchesModels(count: 2, namesPrefix: "today_");

              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async {
                  return matchesToday;
                },
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {
                  // simulate loading from server
                  await Future.delayed(Duration.zero);
                },
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWithProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  widget: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                );
              });

              // skip all frames and go to the end of the frame queue
              await widgetTester.pumpAndSettle();

              final tabTogglerFinder = _findTabToggler(
                propertyChecker: ({
                  required HomeEventsContainer todayContainerChild,
                  required HomeEventsContainer upcomingContainerChild,
                }) {
                  if (todayContainerChild.isLoading) return false;
                  if (upcomingContainerChild.isLoading) return false;

                  return true;
                },
              );

              expect(tabTogglerFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given GetMyMatchesController emits Data state "
            "when widget is rendered"
            "should show [TabToggler] widget with expected 'matches' arguments passed to it",
            (widgetTester) async {
              final matchesToday =
                  getTestMatchesModels(count: 2, namesPrefix: "today_");

              when(() => getMyTodayMatchesUseCase()).thenAnswer(
                (_) async {
                  return matchesToday;
                },
              );
              when(() => loadMyMatchesUseCase()).thenAnswer(
                (_) async {},
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWithProviderScope(
                  overrides: [
                    getMyTodayMatchesUseCaseProvider.overrideWith(
                      (ref) => getMyTodayMatchesUseCase,
                    ),
                    loadMyMatchesUseCaseProvider.overrideWith(
                      (ref) => loadMyMatchesUseCase,
                    ),
                  ],
                  widget: const MaterialApp(
                    home: Scaffold(
                      body: HomeScreenView(),
                    ),
                  ),
                );
              });

              // skip all frames and go to the end of the frame queue
              await widgetTester.pumpAndSettle();

              final tabTogglerFinder = _findTabToggler(
                propertyChecker: ({
                  required HomeEventsContainer todayContainerChild,
                  required HomeEventsContainer upcomingContainerChild,
                }) {
                  final todayMatches = todayContainerChild.matches;
                  final upcomingMatches = upcomingContainerChild.matches;

                  if (todayMatches != matchesToday) return false;
                  // TODO need to implement resolving of upcoming matches
                  if (upcomingMatches.isNotEmpty) return false;

                  return true;
                },
              );

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

Finder _findTabToggler({
  bool Function({
    required HomeEventsContainer todayContainerChild,
    required HomeEventsContainer upcomingContainerChild,
  })? propertyChecker,
}) {
  final tabTogglerFinder = find.byWidgetPredicate((widget) {
    if (widget is! TabToggler) return false;
    if (widget.options.length != 2) return false;

    final option1 = widget.options[0];
    final option2 = widget.options[1];

    final option1Title = option1.title;
    final option2Title = option2.title;

    if (option1Title != "Today") return false;
    if (option2Title != "Following") return false;

    final option1Child = option1.child;
    final option2Child = option2.child;

    if (option1Child is! HomeEventsContainer) return false;
    if (option2Child is! HomeEventsContainer) return false;

    if (propertyChecker == null) return true;

    final doChildrenPropertiesMatch = propertyChecker(
      todayContainerChild: option1Child,
      upcomingContainerChild: option2Child,
    );

    return doChildrenPropertiesMatch;
  });

  return tabTogglerFinder;
}

// TODO potentially move this to some extension general on widget tester
extension on WidgetTester {
  Future<void> pumpWithProviderScope({
    required Widget widget,
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: widget,
      ),
    );
  }
}
