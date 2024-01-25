import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_participants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_toggler.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

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
                arrivingPlayers: [],
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
                arrivingPlayers: [],
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
                arrivingPlayers: [],
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

          testWidgets(
            "given 'Participants' selector is active "
            "when widget is used"
            "should render [MatchTabOptionParticipants] widget with expected arguments",
            (widgetTester) async {
              final participants = List<PlayerModel>.generate(
                10,
                (index) {
                  return PlayerModel(
                    id: index,
                    nickname: "testNickname$index",
                    name: "testName$index",
                    avatarUrl: Uri.parse(
                      "https://test.com/avatar.png",
                    ),
                  );
                },
              );
              final match = MatchModel(
                id: 1,
                arrivingPlayers: participants,
                date: DateTime.now(),
                location: "location",
                name: "name",
                organizer: "organizer",
              );

              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: Scaffold(
                      body: MatchTabOptionToggler(match: match),
                    ),
                  ),
                );

                await widgetTester.tap(find.text("Participants"));
                await widgetTester.pumpAndSettle();
              });

              final matchTabOptionParticipants =
                  find.byWidgetPredicate((widget) {
                if (widget is! MatchTabOptionParticipants) return false;

                final participantsArg = widget.participants;
                if (participantsArg != participants) return false;

                return true;
              });

              expect(matchTabOptionParticipants, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
