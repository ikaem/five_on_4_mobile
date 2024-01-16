import 'dart:io';

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
              avatarUrl: "testAvatarUrl",
            ),
          ));

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
          // https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D

          // TODO interesting to mock network
          // https://stackoverflow.com/a/70694463

          // and this for custom overrids e and http client 
          // https://stackoverflow.com/questions/64119479/override-http-package-globally-in-flutter
          const avatarUrl = "testAvatarUrl";

          await widgetTester.pumpWidget(const MaterialApp(
            home: CurrentUserGreeting(
              nickName: "testNickName",
              teamName: "testTeamName",
              avatarUrl: avatarUrl,
            ),
          ));

          // TODO use this
          // final avatarImage = find.image(const NetworkImage(avatarUrl));
          // final avatarImage = find.byType(Image);
          final avatarImage = find.byType(NetworkImage);

          expect(avatarImage, findsOneWidget);
        },
      );
    },
  );
}

// TODO test only
class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context);
  }
}

// TODO WE CAN  mock this easily - and then return it from mock in http override

class _MockHttpClient extends Fake implements HttpClient {
  @override
  
}