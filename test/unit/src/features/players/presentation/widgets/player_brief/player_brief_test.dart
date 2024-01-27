import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group("PlayerBrief", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given avatarUrl argument is provided"
          "when widget is rendered"
          "should show expected avatar image",
          (widgetTester) async {
            const avatarUrl = "https://test.com/avatar.png";

            await mockNetworkImages(
              () async {
                await widgetTester.pumpWidget(
                  MaterialApp(
                    // TODO this could in theory get entire player object
                    home: PlayerBrief(
                      nickname: "testNickname",
                      avatarUri: Uri.parse(
                        "https://test.com/avatar.png",
                      ),
                    ),
                  ),
                );

                final avatarImage = find.image(const NetworkImage(avatarUrl));

                expect(avatarImage, findsOneWidget);
              },
            );
          },
        );

        testWidgets(
          "given name argument is provided"
          "when widget is rendered"
          "should show expected name",
          (widgetTester) async {
            const nickname = "testNickname";

            await mockNetworkImages(
              () async {
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: PlayerBrief(
                      nickname: nickname,
                      avatarUri: Uri.parse(
                        "https://test.com/avatar.png",
                      ),
                    ),
                  ),
                );

                final nameText = find.text(nickname);

                expect(nameText, findsOneWidget);
              },
            );
          },
        );
      },
    );
  });
}
