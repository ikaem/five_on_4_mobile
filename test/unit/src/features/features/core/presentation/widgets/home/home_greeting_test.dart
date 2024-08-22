import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group(
    "HomeGreeting",
    () {
      testWidgets(
        "given name and team name argument is provided"
        "when widget is rendered"
        "should show expected welcome message",
        (widgetTester) async {
          const nickName = "testNickName";
          const teamName = "testTeamName";

          await mockNetworkImages(() async {
            await widgetTester.pumpWidget(MaterialApp(
                home: HomeGreeting(
              nickName: nickName,
              teamName: teamName,
              avatarUrl: Uri.parse(
                "https://test.com/avatar.png",
              ),
            )));
          });

          final messageNickname = find.text("Welcome, $nickName");
          final messageTeam = find.text("of team $teamName");

          expect(messageNickname, findsOneWidget);
          expect(messageTeam, findsOneWidget);
        },
      );

      testWidgets(
        "given avatarUrl argument is provided"
        "when widget is rendered"
        "should show expected avatar image",
        (widgetTester) async {
          const avatarUrl = "https://test.com/avatar.png";

          await mockNetworkImages(() async {
            await widgetTester.pumpWidget(MaterialApp(
                home: HomeGreeting(
              nickName: "testNickName",
              teamName: "testTeamName",
              avatarUrl: Uri.parse(
                avatarUrl,
              ),
            )));
          });

          final avatarImage = find.image(const NetworkImage(avatarUrl));

          expect(avatarImage, findsOneWidget);
        },
      );
    },
  );
}
