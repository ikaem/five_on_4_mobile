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
        "logo should be shown",
        (widgetTester) async {
          // TODO this will probably need to override dependencies later
          // TODO and will probably need some unified wrapper to push screen on
          await widgetTester.pumpWidget(const MaterialApp(home: LoginScreen()));

          final logoImage =
              find.image(AssetImage(LocalAssetsPathConstants.LOGO_LARGE.value));

          expect(logoImage, findsOneWidget);
        },
      );
    },
  );
}
