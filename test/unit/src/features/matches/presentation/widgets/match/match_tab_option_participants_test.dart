import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_participants.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

// TODO these tests are in a wrong folder - unit

void main() {
  group("MatchTabOptionParticipants", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given empty list of participants is provided"
          "when widget is rendered"
          "should show expected NO PARTICIPANTS text",
          (widgetTester) async {
            final participants = <PlayerModel>[];

            await widgetTester.pumpWidget(
              MaterialApp(
                home: MatchTabOptionParticipants(
                  participants: participants,
                ),
              ),
            );

            final noParticipantsText = find.text("No participants");
            final inviteOneText = find.text("Why not invite some?");

            expect(noParticipantsText, equals(findsOneWidget));
            expect(inviteOneText, equals(findsOneWidget));
          },
        );

        testWidgets(
          "given non-empty list of participants is provided"
          "when widget is rendered"
          "should show expected number of participant briefs",
          (widgetTester) async {
            final participants = List<PlayerModel>.generate(
              10,
              (index) {
                return PlayerModel(
                  id: index,
                  nickname: "testNickname$index",
                  name: "testName$index",
                  avatarUri: Uri.parse(
                    "https://test.com/avatar.png",
                  ),
                );
              },
            );

            await mockNetworkImages(() async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchTabOptionParticipants(
                    participants: participants,
                  ),
                ),
              );
            });

            final participantTop = widgetTester
                .widgetList<PlayerBrief>(
                  find.byType(
                    PlayerBrief,
                  ),
                )
                // .toList()
                .first;
            expect(participantTop.nickname, participants.first.nickname);

            await widgetTester.dragUntilVisible(
              find.text("testNickname9"),
              find.byType(ListView),
              const Offset(0, -1000),
            );

            // at this point, we can only see items at the bottom of the list
            final participantBottom = widgetTester
                .widgetList<PlayerBrief>(
                  find.byType(
                    PlayerBrief,
                  ),
                )
                // .toList()
                .last;
            expect(participantBottom.nickname, participants.last.nickname);
          },
        );
      },
    );
  });
}
