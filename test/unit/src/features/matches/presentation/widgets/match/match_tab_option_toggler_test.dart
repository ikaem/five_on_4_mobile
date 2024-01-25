import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_toggler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";

  group(
    "MatchTabOptionToggler",
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
              organizer: "organizer",
            );

            await widgetTester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: MatchTabOptionToggler(match: match),
                ),
              ),
            );

            final todaySelector = find.text("Info $selectorIndicator");
            final followingEventsSelector =
                find.text("Participants $selectorIndicator");

            expect(todaySelector, findsOneWidget);
            expect(followingEventsSelector, findsNothing);
          },
        );
      });
    },
  );
}
