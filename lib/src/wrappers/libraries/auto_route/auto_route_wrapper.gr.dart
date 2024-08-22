// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_route_wrapper.dart';

abstract class _$AutoRouteWrapper extends RootStackRouter {
  // ignore: unused_element
  _$AutoRouteWrapper({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ErrorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ErrorScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoadingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoadingScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    MatchCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MatchCreateScreen(),
      );
    },
    MatchRoute.name: (routeData) {
      final args = routeData.argsAs<MatchRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MatchScreen(
          key: args.key,
          matchId: args.matchId,
        ),
      );
    },
    PlayerRoute.name: (routeData) {
      final args = routeData.argsAs<PlayerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlayerScreen(
          key: args.key,
          playerId: args.playerId,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
  };
}

/// generated route for
/// [ErrorScreen]
class ErrorRoute extends PageRouteInfo<void> {
  const ErrorRoute({List<PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoadingScreen]
class LoadingRoute extends PageRouteInfo<void> {
  const LoadingRoute({List<PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MatchCreateScreen]
class MatchCreateRoute extends PageRouteInfo<void> {
  const MatchCreateRoute({List<PageRouteInfo>? children})
      : super(
          MatchCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'MatchCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MatchScreen]
class MatchRoute extends PageRouteInfo<MatchRouteArgs> {
  MatchRoute({
    Key? key,
    required int matchId,
    List<PageRouteInfo>? children,
  }) : super(
          MatchRoute.name,
          args: MatchRouteArgs(
            key: key,
            matchId: matchId,
          ),
          initialChildren: children,
        );

  static const String name = 'MatchRoute';

  static const PageInfo<MatchRouteArgs> page = PageInfo<MatchRouteArgs>(name);
}

class MatchRouteArgs {
  const MatchRouteArgs({
    this.key,
    required this.matchId,
  });

  final Key? key;

  final int matchId;

  @override
  String toString() {
    return 'MatchRouteArgs{key: $key, matchId: $matchId}';
  }
}

/// generated route for
/// [PlayerScreen]
class PlayerRoute extends PageRouteInfo<PlayerRouteArgs> {
  PlayerRoute({
    Key? key,
    required int playerId,
    List<PageRouteInfo>? children,
  }) : super(
          PlayerRoute.name,
          args: PlayerRouteArgs(
            key: key,
            playerId: playerId,
          ),
          initialChildren: children,
        );

  static const String name = 'PlayerRoute';

  static const PageInfo<PlayerRouteArgs> page = PageInfo<PlayerRouteArgs>(name);
}

class PlayerRouteArgs {
  const PlayerRouteArgs({
    this.key,
    required this.playerId,
  });

  final Key? key;

  final int playerId;

  @override
  String toString() {
    return 'PlayerRouteArgs{key: $key, playerId: $playerId}';
  }
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
