part of "go_router_wrapper.dart";

class _GoRouterRoutesCreator {
  _GoRouterRoutesCreator();

  GoRoute get authenticatedRoute {
    return GoRoute(
      path: RoutePathsConstants.ROOT.value,
      builder: (context, state) {
        return const MainScreen();
      },
      routes: const [
        // some match screen
        // some match create screen
        // some match edit screen
      ],
    );
  }

  late final loginRoute = _createChildlessRoute(
    path: RoutePathsConstants.LOGIN.value,
    builder: (context, state) {
      return const LoginScreen();
    },
  );

  GoRoute _createChildlessRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) {
    return GoRoute(
      path: path,
      builder: builder,
    );
  }
}
