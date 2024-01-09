import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/main_screen.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part "go_router_routes_creator.dart";

// TODO needed if use router outside of widget tree -> for instance, if want to use router in a controller or outside of App widget for firebase push notifications
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

class GoRouterWrapper {
  GoRouterWrapper();

  final routesCreator = _GoRouterRoutesCreator();

  GoRouter getRouter(bool isLoggedIn) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      routes: [
        routesCreator.authenticatedRoute,
        routesCreator.loginRoute,
      ],
      redirect: (context, state) {
        if (isLoggedIn) {
          return state.uri.path;
        }
        return RoutePathsConstants.LOGIN.value;
      },
    );
  }
}
