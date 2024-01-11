import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/provider/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/main_screen.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/screens/search_screen.dart';
import 'package:five_on_4_mobile/src/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

// TODO needed if use router outside of widget tree -> for instance, if want to use router in a controller or outside of App widget for firebase push notifications
GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

class GoRouterWrapper {
  GoRouterWrapper({required this.ref});

  final Ref ref;

  // final routesCreator = _GoRouterRoutesCreator();

  GoRouter getRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      routes: [
        // authenticated routes
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => MainScreen(
            // key: GlobalKey(debugLabel: "MainScreen"),
            child: child,
          ),
          routes: [
            GoRoute(
              path: RoutePathsConstants.ROOT.value,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                return const HomeScreen();
              },
              routes: [
                // TODO screw it, all will be nested inside "/"
                GoRoute(
                  // parentNavigatorKey: _rootNavigatorKey,
                  path: RoutePathsConstants.MATCH_CREATE.value,
                  builder: (context, state) {
                    return const MatchCreateScreen();
                  },
                ),
                GoRoute(
                  path: RoutePathsConstants.MATCH.value,
                  // has to be _rootNavigatorKey to make sure navigatorBar is not visible
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return const MatchScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              path: RoutePathsConstants.SEARCH.value,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                return const SearchScreen();
              },
            ),
            GoRoute(
              path: RoutePathsConstants.SETTINGS.value,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                return const SettingsScreen();
              },
            ),

            // GoRoute(
            //   path: RoutePathsConstants.MATCH.value,
            //   // parentNavigatorKey: _rootNavigatorKey,
            //   builder: (context, state) {
            //     return const MatchScreen();
            //   },
            // ),
          ],
        ),

        // non authenticated routes
        GoRoute(
          // parentNavigatorKey: _rootNavigatorKey,
          path: RoutePathsConstants.LOGIN.value,
          builder: (context, state) {
            return const LoginScreen();
          },
        )
      ],
      redirect: (context, state) {
        final authDataStatus = ref.watch(authStatusControllerProvider);

        final isLoggedIn = authDataStatus.when(
          data: (data) => data == true,
          loading: () => false,
          error: (error, stackTrace) => false,
        );

        if (isLoggedIn) {
          // by default, it would always go to "/" unless specified differently by some deep link or someting
          // handle that when needed
          return state.uri.path;
        }
        return RoutePathsConstants.LOGIN.value;
      },
    );
  }
}

// class _GoRouterRoutesCreator {
//   _GoRouterRoutesCreator();

//   // TODO problem might be navitation

//   ShellRoute get shellAuthenticatedRoute {
//     return ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       builder: (context, state, child) => MainScreen(
//         child: child,
//       ),
//       routes: [
//         GoRoute(
//           path: RoutePathsConstants.ROOT.value,
//           parentNavigatorKey: _shellNavigatorKey,
//           builder: (context, state) {
//             return const HomeScreen();
//           },
//         ),
//         GoRoute(
//           path: RoutePathsConstants.SEARCH.value,
//           parentNavigatorKey: _shellNavigatorKey,
//           builder: (context, state) {
//             return const Text("This is search");
//           },
//         ),
//         GoRoute(
//           path: RoutePathsConstants.SETTINGS.value,
//           parentNavigatorKey: _shellNavigatorKey,
//           builder: (context, state) {
//             return const Text("This is settings");
//           },
//         ),
//       ],
//     );
//   }

//   // GoRoute get authenticatedRoute {
//   //   return GoRoute(
//   //     path: RoutePathsConstants.ROOT.value,
//   //     builder: (context, state) {
//   //       return const MainScreen();
//   //     },
//   //     routes: const [
//   //       // some match screen
//   //       // some match create screen
//   //       // some match edit screen
//   //     ],
//   //   );
//   // }

//   late final loginRoute = _createChildlessRoute(
//     path: RoutePathsConstants.LOGIN.value,
//     builder: (context, state) {
//       return const LoginScreen();
//     },
//   );

//   GoRoute _createChildlessRoute({
//     required String path,
//     required Widget Function(BuildContext, GoRouterState) builder,
//     // TODO cannot import here because of circular dependency
//     // required GlobalKey<NavigatorState> parentNavigatorKey,
//   }) {
//     return GoRoute(
//       // parentNavigatorKey: _rootNavigatorKey,
//       path: path,
//       builder: builder,
//     );
//   }
// }
