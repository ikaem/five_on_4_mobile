import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/provider/auth_status_controller_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/core_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/five_on_4_app.dart';
import 'package:five_on_4_mobile/src/settings/settings_controller.dart';
import 'package:five_on_4_mobile/src/settings/settings_service.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/extensions/widget_testet_extension.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings(); // stub this

  final authStatusController = _MockAuthStatusController();

  setUpAll(
    () async {
      when(() => authStatusController.isError).thenAnswer(
        (invocation) => false,
      );
      when(() => authStatusController.isLoading).thenAnswer(
        (invocation) => false,
      );
    },
  );

  group(
    "App",
    () {
      testWidgets(
        "given user is not logged in, "
        "when app starts, "
        "then should show LoginScreen",
        (WidgetTester tester) async {
          when(() => authStatusController.isLoggedIn).thenAnswer(
            (invocation) => false,
          );

          await tester.pumpConfiguredWidget(
            widget: FiveOn4App(
              settingsController: settingsController,
            ),
            riverpodOverrides: [
              authStatusControllerProvider
                  .overrideWith((ref) => authStatusController),
            ],
          );

          await tester.pumpAndSettle();

          final screen = find.byKey(AuthScreensKeyConstants.LOGIN_SCREEN.value);
          expect(screen, findsOneWidget);
        },
      );

      testWidgets(
        "given user is logged in, "
        "when app starts, "
        "then should show MainScreen",
        (WidgetTester tester) async {
          when(() => authStatusController.isLoggedIn).thenAnswer(
            (invocation) => true,
          );

          await tester.pumpConfiguredWidget(
            widget: FiveOn4App(
              settingsController: settingsController,
            ),
            riverpodOverrides: [
              authStatusControllerProvider
                  .overrideWith((ref) => authStatusController),
            ],
          );

          await tester.pumpAndSettle();
          final screen = find.byKey(CoreScreensKeyConstants.MAIN_SCREEN.value);
          expect(screen, findsOneWidget);
        },
      );
    },
  );
}

class _MockAuthStatusController extends Mock implements AuthStatusController {}
