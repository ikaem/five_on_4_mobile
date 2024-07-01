import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/authenticate_with_google/authenticate_with_google_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/sign_out/sign_out_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/login/login_with_email_and_password_container.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/login/login_with_google_container.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

// TODO this also needs to be tested

class LoginScreenView extends ConsumerStatefulWidget {
  const LoginScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginScreenViewState();
}

class _LoginScreenViewState extends ConsumerState<LoginScreenView> {
  // late final authenticateWithGoogleController =
  //     ref.read(authenticateWithGoogleControllerProvider);

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticateWithGoogleControllerProvider, (previous, next) {
      // TODO extract this to a method
      next.maybeWhen(
        orElse: () {},
        error: (e, s) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("There was an error authenticating with Google"),
            ),
          );
        },
        data: (state) {
          if (state == false) {
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Authenticated successfully with Google"),
            ),
          );

          // TODO navigate to home screen
        },
      );
    });

    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Image.asset(LocalAssetsPathConstants.LOGO_LARGE.value),
          ),
          const LoginWithEmailAndPasswordContainer(),
          const Divider(),
          LoginWithGoogleContainer(
            onAuthenticate: ref
                .read(authenticateWithGoogleControllerProvider.notifier)
                .onAuthenticate,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              // TODO navigate to register screen
              // context.go("/non-auth/register");
              // context.navigateNamedTo(path)
              // context.go("/login/register");
              // .go(RoutePathsConstants.REGISTER.value.withRouteSlashPrefix);
              // .go(RoutePathsConstants.REGISTER.value);
              context.navigateTo(const RegisterRoute());
            },
            child: const Text("Create account"),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () async {
              ref.read(signOutControllerProvider.notifier).onSignOut();
            },
            child: const Text("Temp google signout"),
          ),
        ],
      ),
    );
  }
}
