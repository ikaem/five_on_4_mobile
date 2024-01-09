import 'dart:io';

import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/five_on_4_app.dart';
import 'package:five_on_4_mobile/src/settings/settings_controller.dart';
import 'package:five_on_4_mobile/src/settings/settings_service.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/path_provider/path_provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO we need to mock things here - widgets tests will not allow http requests

Future<void> main() async {
  group(
    "App",
    () {
// TODO this will use riverpod later
// TODO also possibly use some helper to initialize db with all of tis

      testWidgets(
        "should show LoginScreen when app starts with no previously authenticated user",
        (WidgetTester tester) async {
          // TODO movk the settings conttroller or service eventually
          final settingsController = SettingsController(SettingsService());
          // TODO this should be stubbed
          await settingsController.loadSettings();

          // TODO create test wrapper for app
          await tester.pumpWidget(
            FiveOn4App(
              settingsController: settingsController,
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
          // addTearDown(() {
          //   // TODO clear db
          //   // TODO clear secure storage
          //   // TODO we can also use teardown as well in general to clear db
          // });

          // TODO this will use riverpod later

          print("Hello");
        },
      );
    },
  );
}
