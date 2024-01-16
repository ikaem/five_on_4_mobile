import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CurrentUserGreeting",
    () {
      testWidgets(
        "given name and team name argument is provided"
        "when widget is rendered"
        "should show expected welcome message",
        (widgetTester) async {
          const nickName = "testNickName";
          const teamName = "testTeamName";

          await widgetTester.pumpWidget(const MaterialApp(
            home: CurrentUserGreeting(
                nickName: nickName,
                teamName: teamName,
                avatarUrl: "testAvatarUrl"),
          ));

          final messageWidget =
              find.text("Welcome, $nickName of team $teamName");

          expect(messageWidget, findsOneWidget);
        },
      );
    },
  );
}
