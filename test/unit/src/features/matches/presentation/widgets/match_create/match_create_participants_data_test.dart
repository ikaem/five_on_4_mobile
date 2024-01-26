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

          testWidgets(
            "given non-emnpty list of participants to invite is provided"
            "when screen is rendered"
            "should show expected [PlayerInvitation] widget for each player",
            (widgetTester) async {
              // TODO this will probably need to override dependencies later
              // TODO and will probably need some unified wrapper to push screen on
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchCreateParticipantsData(
                    playersToInvite: [
                      // TODO make this list of playears with some players inside
                    ],
                  ),
                ),
              );

              // will need again that same thing - scrolling and checking that first and 10th are here

              // will also need to test that invitaation widget - it should accept bool for whether user is currently invited, and callback of onTapInvitationAction - which would invite or cancel invitation depending on the state. and it would accept player of course
            },
          );
        },
      );
    },
  );
}
