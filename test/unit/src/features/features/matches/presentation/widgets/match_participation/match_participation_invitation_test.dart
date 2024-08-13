import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  const avatarUrl = "https://test.com/avatar.png";
  final testPlayer = PlayerModel(
    id: 1,
    nickname: "testNickname",
    avatarUri: Uri.parse(avatarUrl),
    name: "testName",
  );

  group(
    "MatchParticipationInvitation",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show expected avatar image",
            (widgetTester) async {
              await mockNetworkImages(
                () async {
                  await widgetTester.pumpWidget(
                    MaterialApp(
                      home: Scaffold(
                        body: MatchPlayerInvitation(
                          player: testPlayer,
                          isAddedToMatchInvitations: false,
                          onInvitationAction: ({
                            required PlayerModel player,
                          }) {},
                        ),
                      ),
                    ),
                  );
                },
              );
              final avatarImage = find.image(
                const NetworkImage(avatarUrl),
              );
              expect(avatarImage, findsOneWidget);
            },
          );

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show expected player nickname",
            (widgetTester) async {
              await mockNetworkImages(
                () async {
                  await widgetTester.pumpWidget(
                    MaterialApp(
                      home: Scaffold(
                        body: MatchPlayerInvitation(
                          player: testPlayer,
                          isAddedToMatchInvitations: false,
                          onInvitationAction: ({
                            required PlayerModel player,
                          }) {},
                        ),
                      ),
                    ),
                  );
                },
              );
              final nicknameText = find.text(testPlayer.nickname);

              expect(nicknameText, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isAddedToMatchInvitations' argument is false"
            "when widget is rendered"
            "should render expected icon button",
            (widgetTester) async {
              await mockNetworkImages(
                () async {
                  await widgetTester.pumpWidget(
                    MaterialApp(
                      home: Scaffold(
                        body: MatchPlayerInvitation(
                          player: testPlayer,
                          isAddedToMatchInvitations: false,
                          onInvitationAction: ({
                            required PlayerModel player,
                          }) {},
                        ),
                      ),
                    ),
                  );
                },
              );

              final addToInvitationsButton = find.widgetWithIcon(
                IconButton,
                Icons.add,
              );

              expect(addToInvitationsButton, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isAddedToMatchInvitations' argument is true"
            "when widget is rendered"
            "should render expected icon button",
            (widgetTester) async {
              await mockNetworkImages(
                () async {
                  await widgetTester.pumpWidget(
                    MaterialApp(
                      home: Scaffold(
                        body: MatchPlayerInvitation(
                          player: testPlayer,
                          isAddedToMatchInvitations: true,
                          onInvitationAction: ({
                            required PlayerModel player,
                          }) {},
                        ),
                      ),
                    ),
                  );
                },
              );

              final removeInvitationsButton = find.widgetWithIcon(
                IconButton,
                Icons.remove,
              );

              expect(removeInvitationsButton, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
