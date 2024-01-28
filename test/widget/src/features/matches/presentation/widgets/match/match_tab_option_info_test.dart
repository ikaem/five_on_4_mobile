import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final match = MatchModel(
    id: 1,
    date: DateTime.now(),
    name: "testName",
    location: "testLocation",
    organizer: "testOrganizer",
    arrivingPlayers: [],
  );
  group(
    "MatchTabOptionInfo",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should render expected widgets",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchTabOptionInfo(
                    match: match,
                  ),
                ),
              );

              final matchInfo = find.byWidgetPredicate((widget) {
                // TODO extract this to function if needed in future
                if (widget is! MatchInfo) return false;
                if (widget.arrivingPlayersNumber !=
                    match.arrivingPlayers.length) {
                  return false;
                }
                if (widget.date != match.date.toString()) {
                  return false;
                }
                if (widget.dayName != "dayName") {
                  return false;
                }
                if (widget.time != "time") {
                  return false;
                }
                if (widget.title != match.name) {
                  return false;
                }
                if (widget.location != match.location) {
                  return false;
                }
                if (widget.organizer != match.organizer) {
                  return false;
                }

                return true;
              });

              expect(matchInfo, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
