import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final match = MatchModel(
    id: 1,
    date: DateTime.now(),
    name: "testName",
    location: "testLocation",
    organizer: "testOrganizer",
    arrivingPlayers: 1,
  );
  group(
    "MatchTabOptionInfoTest",
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

              final matchInfo = find.byType(MatchInfo);

              expect(matchInfo, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
