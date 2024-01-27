import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
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
              mockNetworkImages(
                () async {
                  await widgetTester.pumpWidget(
                    const MaterialApp(
                      home: MatchParticipationInvitation(
                        player: testPlayer,
                        isAddedToMatchInvitations: false,
                      ),
                    ),
                  );

                  final avatarImage = find.image(
                    const NetworkImage("https://test.com/avatar.png"),
                  );
                  expect(avatarUrl, findsOneWidget);
                },
              );
            },
          );

          // testWidgets(
          //   "given 'isAddedToInvitations' argument is true"
          //   "when widget is rendered"
          //   "should render expected icon button",
          //   (widgetTester) async {

          //   },
          // );
        },
      );
    },
  );
}
