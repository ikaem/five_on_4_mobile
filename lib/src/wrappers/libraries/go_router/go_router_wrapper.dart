import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/register/register_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/error_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/loading_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/main_screen.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/screens/search_screen.dart';
import 'package:five_on_4_mobile/src/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// config based on this: https://stackoverflow.com/a/78020076/9661910

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

// TODO needed if use router outside of widget tree -> for instance, if want to use router in a controller or outside of App widget for firebase push notifications
GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

class GoRouterWrapper {
  GoRouterWrapper({
    // required this.ref,
    required this.authStatusController,
    // required this.authDataStatus,
  });

  // final Ref ref;
  // final AsyncValue<bool?> authDataStatus;
  final AuthStatusController authStatusController;

  // final routesCreator = _GoRouterRoutesCreator();

  GoRouter getRouter() {
    return GoRouter(
      // refreshListenable: authDataStatus.when(
      //   data: (data) => null,
      //   loading: () => null,
      //   error: (error, stackTrace) => null,
      // ),
      refreshListenable: authStatusController,
      // refreshListenable: GoRouterRefreshStream

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
                  path: "${RoutePathsConstants.MATCH.value}/:id",
                  // has to be _rootNavigatorKey to make sure navigatorBar is not visible
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final matchId =
                        int.tryParse(state.pathParameters['id'] ?? "");

                    if (matchId == null) {
                      // TODO this should redirect to ErrorPage later
                      return Scaffold(
                        appBar: AppBar(),
                        body: const Center(
                          child: Text("Match id is null"),
                        ),
                      );
                    }
                    return MatchScreen(
                      matchId: matchId,
                    );
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
          parentNavigatorKey: _rootNavigatorKey,
          path: RoutePathsConstants.LOGIN.value,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),

        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: RoutePathsConstants.REGISTER.value,
          builder: (context, state) {
            return const RegisterScreen();
          },
        ),

        // misc routes
        GoRoute(
          path: RoutePathsConstants.LOADING.value,
          // parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return const LoadingScreen();
          },
        ),
        GoRoute(
          path: RoutePathsConstants.ERROR.value,
          // parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            // return const Text("This is error");
            return const ErrorScreen();
          },
        ),
      ],
      redirect: (context, state) {
        // TODO also, maybe we should disable redirection in certain cases
        // for instance, when are not in checking authentication flow - this about this - it would make it easier

        // TODO abstract this
        final isLoggedIn = authStatusController.isLoggedIn;
        final isError = authStatusController.isError;
        final isLoading = authStatusController.isLoading;

        final fullPath = state.fullPath;

        log(
          "----------- PRINTING VALUES WHEN REDIRECT: ----------------\n"
          "isLoggedIn: $isLoggedIn\n"
          "isError: $isError\n"
          "isLoading: $isLoading\n"
          "fullPath: $fullPath\n"
          "----------------------------------------------------------\n",
        );

        final nonLoggedInRoutes = [
          RoutePathsConstants.LOGIN.value,
          RoutePathsConstants.REGISTER.value,
        ];

        // TODO abstract this
        if (isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "There was an error with getting the authentication status. Please login or try again later,"),
            ),
          );
        }

        if (!isLoggedIn) {
          final redirectPath = _getRedirectPathWhenNotLoggedIn(state);
          return redirectPath;
          // return RoutePathsConstants.LOGIN.value;
          // context.replace(RoutePathsConstants.LOGIN.value);
          // return null;
        }

        // now we are logged in

        // TODO this redirection needs more work
        // return null;
        // TODO this will prevent navigation
        // return "/";
        // return null;

        final redirectPath = _getRedirectPathWhenLoggedIn(state);
        print("redirect path when logged in: $redirectPath");

        return "/";

        // return null;

        // if (isLoading) {
        //   return RoutePathsConstants.LOADING.value;
        // }

        // // TODO test only
        // // if (isError) {
        // //   return RoutePathsConstants.ERROR.value;
        // // }

        // if (!isLoggedIn) {
        //   return RoutePathsConstants.LOGIN.value;
        // }

        // return state.uri.path;
      },
    );
  }

  String _getRedirectPathWhenNotLoggedIn(GoRouterState state) {
    if (state.fullPath == "/") {
      return RoutePathsConstants.LOGIN.value;
    }

    if (state.fullPath == RoutePathsConstants.LOGIN.value) {
      return RoutePathsConstants.LOGIN.value;
    }

    // now there is register
    if (state.fullPath == RoutePathsConstants.REGISTER.value) {
      return RoutePathsConstants.REGISTER.value;
    }

    return RoutePathsConstants.LOGIN.value;
  }
}

String? _getRedirectPathWhenLoggedIn(GoRouterState state) {
  if (state.fullPath == "/") {
    return RoutePathsConstants.ROOT.value;
  }

  final fullPath = state.fullPath;
  // TODO not sure if this is relevant
  // if (fullPath == RoutePathsConstants.LOGIN.value) {
  //   return RoutePathsConstants.ROOT.value;
  // }

  if (fullPath == null) return null;

  return fullPath;
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
