import 'package:five_on_4_mobile/src/five_on_4_app.dart';
import 'package:five_on_4_mobile/src/settings/settings_controller.dart';
import 'package:five_on_4_mobile/src/settings/settings_service.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/go_router/provider/go_router_wrapper_provider.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/provider/isar_wrapper_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final providerContainer = ProviderContainer();

  // TODO database needs to be initialized before this
  final isarWrapper = providerContainer.read(isarWrapperProvider);
  await isarWrapper.initialize();
  // final goRouterWrapper = providerContainer.read(goRouterWrapperProvider);

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(FiveOn4App(settingsController: settingsController));
  runApp(
    ProviderScope(
      overrides: [
        isarWrapperProvider.overrideWith((ref) => isarWrapper),
      ],
      child: FiveOn4App(
        settingsController: settingsController,
        // goRouter: goRouterWrapper.getRouter(),
      ),
    ),
  );
}
