import 'dart:math';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_today.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief_extended.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CurrentUserTodayEvents",
    () {
// TODO do this everwhere in these widget tests
      group("Layout", () {
        testWidgets(
          "given empty list of todays matches are provided"
          "when widget is rendered"
          "should show expexted NO MATCHES text",
          (widgetTester) async {
            final todaysMatches = <MatchModel>[];

            await widgetTester.pumpWidget(
              MaterialApp(
                home: CurrentUserEventsToday(
                  matches: todaysMatches,
                ),
              ),
            );

            // find texts with messages for no match

            final noMatchesText = find.text("No matches today");
            final restTodayText = find.text("Have a rest, you deserve it!");

            expect(noMatchesText, findsOneWidget);
            expect(restTodayText, findsOneWidget);
          },
        );

        testWidgets(
          "given non-empty list of todays matches are provided"
          "when widget is rendered"
          "should show expexted number of match briefs",
          (widgetTester) async {
            final todaysMatches = <MatchModel>[
              MatchModel(
                id: 1,
                date: DateTime.now(),
                name: "testName1",
                location: "testLocation1",
                organizer: "testOrganizer1",
                arrivingPlayers: 0,
              ),
              MatchModel(
                id: 2,
                date: DateTime.now(),
                name: "testName2",
                location: "testLocation2",
                organizer: "testOrganizer2",
                arrivingPlayers: 0,
              ),
            ];

            await widgetTester.pumpWidget(
              MaterialApp(
                home: CurrentUserEventsToday(
                  matches: todaysMatches,
                ),
              ),
            );

            // TODO this is also an option
            // final matchBriefs = find.byType(MatchBriefExtended);
            // matchBriefs.evaluate();

            final matchBriefs = widgetTester
                .widgetList<MatchBriefExtended>(find.byType(MatchBriefExtended))
                .toList();

            final first = matchBriefs.first;
            final last = matchBriefs.last;

            expect(first.title, equals(todaysMatches.first.name));

            expect(last.title, equals(todaysMatches.last.name));
          },
        );
      });

      group(
        "Navigation",
        () {
          // test that tapping on match navigates to screen and has match with specific data rendered there - or that the screen is called with specific value - maybe that is better - the id is passed to instance of screen
        },
      );
    },
  );
}
