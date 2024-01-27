import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_invite_form.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "MatchCreateParticipantsInviteForm",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show 'PLAYER NAME / NICKNAME' TextField",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MatchCreateParticipantsInviteForm(
                      foundPlayers: const [],
                      onPlayerSearch: ({
                        required String playerIdentifier,
                      }) async {},
                      onInvitationAction: ({
                        required PlayerModel player,
                      }) {},
                    ),
                  ),
                ),
              );

              final playerNameTextField = find.ancestor(
                of: find.text("PLAYER NAME / NICKNAME"),
                matching: find.byType(TextField),
              );

              expect(playerNameTextField, findsOneWidget);
            },
          );

          testWidgets(
            "given empty list of foundPlayers"
            "when widget is rendered"
            "should show 'No players found' message",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MatchCreateParticipantsInviteForm(
                      foundPlayers: const [],
                      onPlayerSearch: ({
                        required String playerIdentifier,
                      }) async {},
                      onInvitationAction: ({
                        required PlayerModel player,
                      }) {},
                    ),
                  ),
                ),
              );

              final noPlayersFoundText = find.text("No players found");

              expect(noPlayersFoundText, findsOneWidget);
            },
          );

          // testWidgets(
          //   "given non-empty foundPlayers"
          //   "when widget is rendered"
          //   "should show expected [MatchPlayerInvitation] widget for each player",
          //   (widgetTester) async {
          //     final foundPlayers = getTestPlayers(count: 5);

          //     await widgetTester.pumpWidget(
          //       MaterialApp(
          //         home: Scaffold(
          //           body: MatchCreateParticipantsInviteForm(
          //             foundPlayers: foundPlayers,
          //             onPlayerSearch: ({
          //               required String playerIdentifier,
          //             }) async {},
          //             onInvitationAction: ({
          //               required PlayerModel player,
          //             }) {},
          //           ),
          //         ),
          //       ),
          //     );

          //     final foundPlayerTop = widgetTester
          //         .widgetList<MatchPlayerInvitation>(
          //           find.byType(MatchPlayerInvitation),
          //         )
          //         .first;
          //     expect(foundPlayerTop.player, equals(foundPlayers.first));

          //     await widgetTester.dragUntilVisible(
          //       find.text("test_nickname4"),
          //       find.byType(ListView),
          //       const Offset(0, -1000),
          //     );

          //     final foundPlayerBottom = widgetTester
          //         .widgetList<MatchPlayerInvitation>(
          //           find.byType(MatchPlayerInvitation),
          //         )
          //         .last;
          //     expect(foundPlayerBottom.player, equals(foundPlayers.last));
          //   },
          // );
        },
      );
    },
  );
}
