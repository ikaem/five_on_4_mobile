import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchCreateParticipantsData",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given empty list of participants to invite is provided"
            "when screen is rendered"
            "should show 'NO INVITES' message",
            (widgetTester) async {
              // TODO this will probably need to override dependencies later
              // TODO and will probably need some unified wrapper to push screen on
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchCreateParticipantsData(
                    playersToInvite: [],
                  ),
                ),
              );

              final noInvitesText =
                  find.text("No players have been invited to the match");
              final inviteOneText =
                  find.text("Why don’t you reach out to some?");

              expect(noInvitesText, findsOneWidget);
              expect(inviteOneText, findsOneWidget);
            },
          );

          testWidgets(
            "given empty list of participants to invite is provided"
            "when screen is rendered"
            "should show 'Invite players' button",
            (widgetTester) async {
              // TODO this will probably need to override dependencies later
              // TODO and will probably need some unified wrapper to push screen on
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchCreateParticipantsData(
                    playersToInvite: [],
                  ),
                ),
              );

              final inviteButton = find.ancestor(
                  of: find.text("Invite players"),
                  matching: find.byType(ElevatedButton));
            },
          );
        },
      );
    },
  );
}
