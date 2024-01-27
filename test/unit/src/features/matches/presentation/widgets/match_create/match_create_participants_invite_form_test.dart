import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
            "should show 'PLAYER NAME' TextField",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchCreateParticipantsInviteForm(
                    foundPlayers: [],
                    onPlayerSearch: () {},
                    onInvitationAction: ({
                      required PlayerModel player,
                    }) {},
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
        },
      );
    },
  );
}
