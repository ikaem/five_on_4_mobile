import 'dart:math';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_today_events.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief_extended.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CurrentUserTodayEvents",
    () {
      testWidgets(
        "given empty list of todays matches are provided"
        "when widget is rendered"
        "should show expexted NO MATCHES text",
        (widgetTester) async {
          final todaysMatches = <MatchModel>[];

          await widgetTester.pumpWidget(
            MaterialApp(
              home: CurrentUserTodayEvents(
                todaysMatches: todaysMatches,
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
              home: CurrentUserTodayEvents(
                todaysMatches: todaysMatches,
              ),
            ),
          );

          // TODO this is also an option
          // final matchBriefs = find.byType(MatchBriefExtended);
          // matchBriefs.evaluate();

          final matchBriefsAnotherWay = widgetTester
              .widgetList<MatchBriefExtended>(find.byType(MatchBriefExtended))
              .toList();

          final first = matchBriefsAnotherWay.first;
          final last = matchBriefsAnotherWay.last;

          expect(first.title, equals(todaysMatches.first.name));
          expect(last.title, equals(todaysMatches.last.name));
        },
      );
    },
  );
}
