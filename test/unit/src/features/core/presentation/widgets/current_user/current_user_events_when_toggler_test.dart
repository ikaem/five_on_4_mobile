import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_following.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_when_toggler.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_today.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";

  group(
    "CurrentUserEventsWhenToggler",
    () {
      group(
        "Tabbing",
        () {
          testWidgets(
            "given user has performed no actions"
            "when widget is rendered"
            "should have 'Today' selector selected by default, and not 'Following events'",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: CurrentUserEventsWhenToggler(
                      matchesToday: [],
                      matchesFollowing: [],
                    ),
                  ),
                ),
              );

              final todaySelector = find.text("Today $selectorIndicator");
              final followingEventsSelector =
                  find.text("Following matches $selectorIndicator");

              expect(todaySelector, findsOneWidget);
              expect(followingEventsSelector, findsNothing);
            },
          );

          testWidgets(
            "given user selects 'following events'"
            "when widget is used"
            "should have 'Following' selector selected, and not 'Today'",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: CurrentUserEventsWhenToggler(
                      matchesToday: [],
                      matchesFollowing: [],
                    ),
                  ),
                ),
              );

              await widgetTester.tap(find.text("Following matches"));
              await widgetTester.pumpAndSettle();

              final todaySelector = find.text("Today $selectorIndicator");
              final followingEventsSelector =
                  find.text("Following matches $selectorIndicator");

              expect(todaySelector, findsNothing);
              expect(followingEventsSelector, findsOneWidget);
            },
          );
        },
      );
      group("Layout", () {
        testWidgets(
          "given 'Today' selector is active "
          "when widget is used"
          "should render [CurrentUserEventsToday] widget",
          (widgetTester) async {
            final todaysMatches = <MatchModel>[];

            await widgetTester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: CurrentUserEventsWhenToggler(
                    matchesToday: todaysMatches,
                    matchesFollowing: const [],
                  ),
                ),
              ),
            );
// TODO use widgetbypredicte to make sure correct arguments are passed
            final eventsTodayWidget = find.byType(CurrentUserEventsToday);

            expect(eventsTodayWidget, findsOneWidget);
          },
        );

        testWidgets(
          "given 'Following events' selector is active "
          "when widget is used"
          "should render [CurrentUserEventsFollowing] widget",
          (widgetTester) async {
            final matchesFollowing = <MatchModel>[];

            await widgetTester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: CurrentUserEventsWhenToggler(
                    matchesToday: const [],
                    matchesFollowing: matchesFollowing,
                  ),
                ),
              ),
            );

            await widgetTester.tap(find.text("Following matches"));
            await widgetTester.pumpAndSettle();

            final followingEventsWidget =
                find.byType(CurrentUserEventsFollowing);
            expect(followingEventsWidget, findsOneWidget);
          },
        );
      });
    },
  );
}
