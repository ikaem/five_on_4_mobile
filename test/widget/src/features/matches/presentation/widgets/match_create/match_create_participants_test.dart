import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "MatchCreateParticipants",
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
                  home: MatchCreateParticipants(
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
                  home: MatchCreateParticipants(
                    playersToInvite: [],
                  ),
                ),
              );

              final inviteButton = find.ancestor(
                of: find.text("Invite players"),
                matching: find.byType(ElevatedButton),
              );

              expect(inviteButton, findsOneWidget);
            },
          );

          testWidgets(
            "given non-emnpty list of participants to invite is provided"
            "when screen is rendered"
            "should show expected [MatchPlayerInvitation] widget for each player",
            (widgetTester) async {
              final playersToInvite = getTestPlayers(
                count: 10,
              );

              await mockNetworkImages(() async {
                // TODO this will probably need to override dependencies later
                // TODO and will probably need some unified wrapper to push screen on
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: Scaffold(
                      body: MatchCreateParticipants(
                        playersToInvite: playersToInvite,
                      ),
                    ),
                  ),
                );
              });

              final invitedPlayerTop = widgetTester
                  .widgetList<MatchPlayerInvitation>(
                      find.byType(MatchPlayerInvitation))
                  .first;

              expect(invitedPlayerTop.player, equals(playersToInvite.first));

              await widgetTester.dragUntilVisible(
                find.text("test_nickname9"),
                find.byType(ListView),
                const Offset(0, -1000),
              );

              final invitedPlayerBottom = widgetTester
                  .widgetList<MatchPlayerInvitation>(
                      find.byType(MatchPlayerInvitation))
                  .last;

              expect(invitedPlayerBottom.player, equals(playersToInvite.last));
            },
          );

          testWidgets(
            "given non-emnpty list of participants to invite is provided"
            "when screen is rendered"
            "should show 'Invite players' button",
            (widgetTester) async {
              final playersToInvite = getTestPlayers(
                count: 1,
              );

              await mockNetworkImages(() async {
                // TODO this will probably need to override dependencies later
                // TODO and will probably need some unified wrapper to push screen on
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: Scaffold(
                      body: MatchCreateParticipants(
                        playersToInvite: playersToInvite,
                      ),
                    ),
                  ),
                );
              });

              final inviteButton = find.ancestor(
                of: find.text("Invite players"),
                matching: find.byType(ElevatedButton),
              );

              expect(inviteButton, findsOneWidget);
            },
          );
        },
      );

      group(
        "Invite players interaction",
        () {
          testWidgets(
            "given widget is rendered"
            "when when 'Invite players' button is pressed"
            "should show 'Invite players' dialog",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: MatchCreateParticipants(
                    playersToInvite: [],
                  ),
                ),
              );

              final inviteButton = find.ancestor(
                of: find.text("Invite players"),
                matching: find.byType(ElevatedButton),
              );

              await widgetTester.tap(inviteButton);
              await widgetTester.pumpAndSettle();

              final invitePlayersDialog = find.ancestor(
                of: find.text("INVITE PLAYERS"),
                matching: find.byType(Dialog),
              );

              expect(invitePlayersDialog, findsOneWidget);
            },
          );

          // should show widget of type MatchCreateParticipantsInviteForm (with proper arguments)
        },
      );
    },
  );
}
