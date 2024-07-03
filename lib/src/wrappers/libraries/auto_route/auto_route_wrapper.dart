import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/register/register_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/error_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/loading_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/main_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/screens/search_screen.dart';
import 'package:five_on_4_mobile/src/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

part "auto_route_wrapper.gr.dart";

@AutoRouterConfig()
class AutoRouteWrapper extends _$AutoRouteWrapper implements AutoRouteGuard {
  // AutoRouteWrapper({
  //   required AuthStatusController authStatusController,
  // }) : _authStatusController = authStatusController;

  // final AuthStatusController _authStatusController;

  AutoRouteWrapper();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoadingRoute.page,
          initial: true,
          // initial: true,
        ),
        AutoRoute(
          page: MainRoute.page,
          // initial: true,
          children: [
            AutoRoute(
              page: HomeRoute.page,
            ),
            // AutoRoute(
            //   page: MatchRoute.page,
            // ),
            AutoRoute(
              page: SearchRoute.page,
            ),
            AutoRoute(
              page: SettingsRoute.page,
            ),
          ],
        ),
        AutoRoute(page: MatchCreateRoute.page),
        AutoRoute(page: MatchRoute.page),
        // AutoRoute(
        //   page: MatchRoute.page,
        // ),
        // TODO these probably need to be nested
        // AutoRoute(
        //   page: HomeRoute.page,
        // ),
        // AutoRoute(
        //   page: MatchRoute.page,
        // ),
        // AutoRoute(
        //   page: SearchRoute.page,
        // ),
        // AutoRoute(
        //   page: SettingsRoute.page,
        // ),
        AutoRoute(
          page: LoginRoute.page,
          // /* TODO wont always be */
          // initial: true,
        ),
        AutoRoute(page: RegisterRoute.page),
      ];

  @override
  void onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) {
    // TODO maybe not needed either
    // final isLoggedIn = _authStatusController.isLoggedIn;
    // final isLoading = _authStatusController.isLoading;
    // final isError = _authStatusController.isError;
    // TODO: I am not sure what this onResult is - maybe i dont need to use it
    // resolver.redirect(const LoginRoute());
    resolver.next();
    // return;

    // if (isLoggedIn) {
    //   resolver.next(true);
    //   return;
    // }

    // resolver.redirect(LoginRoute(
    //   onLogin: (isLoggedIn) {
    //     resolver.next(isLoggedIn);
    //   },
    // ));

    // if (!isLoading) {
    //   resolver.next(true);
    //   return;
    // }

    // if (isLoading) {
    //   // resolver.next();
    //   resolver.redirect(const LoadingRoute());
    //   return;
    // }

    // if (isLoggedIn) {
    //   resolver.redirect(const ErrorRoute());
    //   return;
    // }

    // if (isLoggedIn && resolver.route.name == LoadingRoute.name) {
    //   resolver.next();
    //   return;
    // }

    // if (!isLoggedIn && resolver.route.name == LoginRoute.name) {
    //   resolver.next();
    //   return;
    // }

    // if (isLoggedIn) {
    //   // router.navigate(const LoadingRoute());
    //   resolver.redirect(const LoadingRoute());

    //   return;
    // }

    // if (!isLoggedIn) {
    //   // router.navigate(const LoginRoute());
    //   resolver.redirect(const LoginRoute());
    //   return;
    // }
  }
}
