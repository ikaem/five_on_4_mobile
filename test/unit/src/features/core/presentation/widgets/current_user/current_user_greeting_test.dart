import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_greeting.dart';
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

          final messageNickname = find.text("Welcome, $nickName");
          final messageTeam = find.text("of team $teamName");

          expect(messageNickname, findsOneWidget);
          expect(messageTeam, findsOneWidget);
        },
      );
    },
  );
}