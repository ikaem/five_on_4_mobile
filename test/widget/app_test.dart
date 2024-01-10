import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/provider/auth_local_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/five_on_4_app.dart';
import 'package:five_on_4_mobile/src/settings/settings_controller.dart';
import 'package:five_on_4_mobile/src/settings/settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

Future<void> main() async {
  group(
    "App",
    () {
      testWidgets(
        "should show LoginScreen when app starts with no previously authenticated user",
        (WidgetTester tester) async {
          final authLocalDataSource = _MockAuthLocalDataSource();
          when(() => authLocalDataSource.getAuthData()).thenAnswer(
            (_) async => AuthDataEntity(
              playerInfo: AuthDataPlayerInfoEntity(),
              teamInfo: AuthDataTeamInfoEntity(),
            ),
          );
          final settingsController = SettingsController(SettingsService());
          await settingsController.loadSettings(); // stub this

          // TODO create test wrapper for app
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authLocalDataSourceProvider
                    .overrideWith((ref) => authLocalDataSource)
              ],
              child: FiveOn4App(
                settingsController: settingsController,
              ),
            ),
          );

          await tester.pumpAndSettle();

          final loginButton = find.text("Login");
          expect(loginButton, findsOneWidget);
        },
      );

      testWidgets(
        "should show HomeScreen when app starts with a previously authenitcated user",
        (WidgetTester tester) async {
          final authLocalDataSource = _MockAuthLocalDataSource();
          when(() => authLocalDataSource.getAuthData()).thenAnswer(
            (_) async => AuthDataEntity(
              playerInfo: AuthDataPlayerInfoEntity(),
              teamInfo: AuthDataTeamInfoEntity(),
            ),
          );

          final settingsController = SettingsController(SettingsService());
          await settingsController.loadSettings(); // stub this

          await tester.pumpWidget(
            // create wrapper for test app
            ProviderScope(
              overrides: [
                authLocalDataSourceProvider
                    .overrideWith((ref) => authLocalDataSource)
              ],
              child: FiveOn4App(
                settingsController: settingsController,
              ),
            ),
          );

          await tester.pumpAndSettle();

          final loginButton = find.text("Main Screen");
          expect(loginButton, findsOneWidget);
        },
      );
    },
  );
}

class _MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}
