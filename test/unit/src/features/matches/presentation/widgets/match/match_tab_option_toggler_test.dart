import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_toggler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";

  group(
    "MatchTabOptionToggler",
    () {
      group(
        "Tabbing",
        () {
          // help me

          testWidgets(
            "given user has performed no actions"
            "when widget is rendered"
            "should have 'Info' selector selected by default, and not 'Participants'",
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

              final infoSelector = find.text("Info $selectorIndicator");
              final participantsSelector =
                  find.text("Participants $selectorIndicator");

              expect(infoSelector, findsOneWidget);
              expect(participantsSelector, findsNothing);
            },
          );

          testWidgets(
            "given user selects 'participatns'"
            "when widget is rendered"
            "should have 'Participants' selector selected, and not 'Info'",
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

              await widgetTester.tap(find.text("Participants"));
              await widgetTester.pumpAndSettle();

              final infoSelector = find.text("Info $selectorIndicator");
              final participantsSelector =
                  find.text("Participants $selectorIndicator");

              expect(infoSelector, findsNothing);
              expect(participantsSelector, findsOneWidget);
            },
          );
        },
      );

      group(
        "Layout",
        () {
          testWidgets(
            "given 'Info' selector is active "
            "when widget is used"
            "should render [MatchTabOptionInfo] widget with expected arguments",
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

              final matchTabOoptionInfo = find.byWidgetPredicate((widget) {
                if (widget is! MatchTabOptionInfo) return false;

                final matchArg = widget.match;
                if (matchArg != match) return false;

                return true;
              });

              expect(matchTabOoptionInfo, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
