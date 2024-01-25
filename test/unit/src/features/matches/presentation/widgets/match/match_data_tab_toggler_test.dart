import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";

  group(
    "MatchDataTabToggler",
    () {
      group("Tabbing", () {
        // help me

        testWidgets(
          "given user has performed no actions"
          "when widget is rendered"
          "should have 'Today' selector selected by default, and not 'Following events'",
          (widgetTester) async {
            final match = MatchModel(
              id: 1,
              // TODO this should be a list of Players
              arrivingPlayers: 12,
              date: DateTime.now(),
              location: "location",
              name: "name",
              organizer: "organizer",„
            );

            await widgetTester.pumpWidget(
              const MaterialApp(
                home: Scaffold(
                  body: MatchDataTabToggler(match),
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
      });
    },
  );
}
