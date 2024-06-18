import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/provider/auth_status_controller_provider.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/go_router/go_router_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/go_router/provider/go_router_wrapper_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:go_router/go_router.dart';
import 'settings/settings_controller.dart';

// final _goRouterWrapper = GoRouterWrapper();

// final shellNavigatorKey = GlobalKey<NavigatorState>();
// final rootNavigatorKey = GlobalKey<NavigatorState>();

// TODO figure this out somehow - i dont want to have it here - can i move it to the wrapper?
// https://github.com/flutter/flutter/issues/113757
// https://gist.github.com/tolo/b26bd0ccb89a5fa2e57ec715f8963f2a

class FiveOn4App extends ConsumerStatefulWidget {
  const FiveOn4App({
    super.key,
    required this.settingsController,
    // required this.goRouter,
  });

  final SettingsController settingsController;
  // final GoRouter goRouter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FiveOn4AppState();
}

class _FiveOn4AppState extends ConsumerState<FiveOn4App> {
  // late final _router = ref.read(goRouterWrapperProvider).getRouter();
  // final router = getRouter();
  // final router = GoRouterWrapper().getRouter();

// TODO maaaybe this can go up outside the app
  late final _router = GoRouterWrapper(
          authStatusController:
              ref.read<AuthStatusController>(authStatusControllerProvider))
      .getRouter();

  @override
  Widget build(BuildContext context) {
    // ref.listen(authStatusControllerProvider, (previous, next) {
    //   print("hello");
    // });

    // ref.listen<AuthStatusController>(authStatusControllerProvider,
    //     (previous, next) {
    //   final isError = next.isError;
    //   if (!isError) return;

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text(
    //           "There was an error with getting the authentication status. Please try again later,"),
    //     ),
    //   );

    //   // context.go(RoutePathsConstants.LOGIN.value);
    // });

    // authStatusController.

    // final isLoggedIn = ref.watch(authStatusControllerProvider).when(
    //       data: (data) => data == true,
    //       loading: () => false,
    //       error: (error, stackTrace) => false,
    //     );

    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          // routerConfig: _goRouterWrapper.getRouter(isLoggedIn),
          // routerConfig: widget.goRouter,
          routerConfig: _router,
          // builder: (context, child) {
          //   // TODO this will insert widgets above the navigator or Router when .router is used
          //   // so some toast wrapper
          // },
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'five_on_4_app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,
          // TODO this is temp only
          // home: const LoginScreen(),

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          // TODO come back to this
          // onGenerateRoute: (RouteSettings routeSettings) {
          //   return MaterialPageRoute<void>(
          //     settings: routeSettings,
          //     builder: (BuildContext context) {
          //       switch (routeSettings.name) {
          //         case SettingsView.routeName:
          //           return SettingsView(controller: settingsController);
          //         case SampleItemDetailsView.routeName:
          //           return const SampleItemDetailsView();
          //         case SampleItemListView.routeName:
          //         default:
          //           return const SampleItemListView();
          //       }
          //     },
          //   );
          // },
        );
      },
    );
  }
}
