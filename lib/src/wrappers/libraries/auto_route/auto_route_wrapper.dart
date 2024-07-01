import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/register/register_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/screens/search_screen.dart';
import 'package:five_on_4_mobile/src/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

part "auto_route_wrapper.gr.dart";

@AutoRouterConfig()
class AutoRouteWrapper extends _$AutoRouteWrapper {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          // /* TODO wont always be */
          initial: true,
        ),
        AutoRoute(page: RegisterRoute.page),
      ];
}
