import 'dart:math';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_today_events.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief_extended.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CurrentUserAllEvents",
    () {
      testWidgets(
        "given empty list of matches are provided"
        "when widget is rendered"
        "should show expexted NO MATCHES text",
        (widgetTester) async {
          final matches = <MatchModel>[];

          await widgetTester.pumpWidget(
            MaterialApp(
              home: CurrentUserAllEvents(
                matches: matches,
              ),
            ),
          );

          // find texts with messages for no match

          final noMatchesText = find.text("No joined matches");
          final joineOneText = find.text("Why not join one?");

          expect(noMatchesText, findsOneWidget);
          expect(joineOneText, findsOneWidget);
        },
      );

      // testWidgets(
      //   "given non-empty list of matches are provided"
      //   "when widget is rendered"
      //   "should show expexted number of match briefs",
      //   (widgetTester) async {
      //     final todaysMatches = <MatchModel>[
      //       MatchModel(
      //         id: 1,
      //         date: DateTime.now(),
      //         name: "testName1",
      //         location: "testLocation1",
      //         organizer: "testOrganizer1",
      //         arrivingPlayers: 0,
      //       ),
      //       MatchModel(
      //         id: 2,
      //         date: DateTime.now(),
      //         name: "testName2",
      //         location: "testLocation2",
      //         organizer: "testOrganizer2",
      //         arrivingPlayers: 0,
      //       ),
      //     ];
      //   },
      // );
    },
  );
}