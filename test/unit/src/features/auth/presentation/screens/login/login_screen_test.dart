import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO here how to test proper image shown
// https://stackoverflow.com/questions/65812452/how-to-test-image-widgets-source-path-in-flutter
void main() {
  group(
    "LoginScreen",
    () {
      testWidgets(
        "given navigate to Login screen"
        "when screen is rendered"
        "should show logo image",
        (widgetTester) async {
          // TODO this will probably need to override dependencies later
          // TODO and will probably need some unified wrapper to push screen on
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final logoImage =
              find.image(AssetImage(LocalAssetsPathConstants.LOGO_LARGE.value));

          expect(logoImage, findsOneWidget);
        },
      );
      testWidgets(
        "given navigate to Login screen"
        "when screen is rendered"
        "should show nickname TextField",
        (widgetTester) async {
          // find specific widget by ancestor from here - https://stackoverflow.com/questions/74616390/flutter-test-find-by-specific-textfield
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final nicknameTextField = find.ancestor(
              of: find.text("Nickname"), matching: find.byType(TextField));

          expect(nicknameTextField, findsOneWidget);
        },
      );

      testWidgets(
        "given navigate to Login screen"
        "when screen is rendered"
        "should shown password TextField",
        (widgetTester) async {
          // find specific widget by ancestor from here - https://stackoverflow.com/questions/74616390/flutter-test-find-by-specific-textfield
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final passwordTextField = find.ancestor(
              of: find.text("Password"), matching: find.byType(TextField));

          expect(passwordTextField, findsOneWidget);
        },
      );

      testWidgets(
        "given navigate to Login screen"
        "when password TextField is shown"
        "should have text obscured",
        (widgetTester) async {
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final passwordTextField = find.ancestor(
              of: find.text("Password"), matching: find.byType(TextField));

          final input = widgetTester.firstWidget<TextField>(passwordTextField);

          expect(input.obscureText, isTrue);
        },
      );

      testWidgets(
        "given navigate to Login screen"
        "when screen is rendered"
        "should shown Login button",
        (widgetTester) async {
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final loginButton = find.ancestor(
              of: find.text("Login"), matching: find.byType(ElevatedButton));

          expect(loginButton, findsOneWidget);
        },
      );

      testWidgets(
        "given navigate to Login screen"
        "when screen is rendered"
        "should shown Google Login button",
        (widgetTester) async {
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final loginButton = find.ancestor(
              of: find.text("Login with Google"),
              matching: find.byType(ElevatedButton));

          expect(loginButton, findsOneWidget);
        },
      );
    },
  );
}
