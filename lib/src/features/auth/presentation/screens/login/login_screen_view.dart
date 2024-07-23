import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/authenticate_with_google/authenticate_with_google_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/login/login_with_email_and_password_container.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/login/login_with_google_container.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreenView extends ConsumerStatefulWidget {
  const LoginScreenView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginScreenViewState();
}

class _LoginScreenViewState extends ConsumerState<LoginScreenView> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      authenticateWithGoogleControllerProvider,
      _handleAuthenticateWithGoogleControllerStateChange,
    );

    return Scaffold(
      // TODO use theme
      backgroundColor: ColorConstants.BLUE_LIGHT,
      body: Padding(
        padding: const EdgeInsets.all(SpacingConstants.L),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Image.asset(LocalAssetsPathConstants.LOGO_LARGE.value),
                ),
                const SizedBox(
                  height: SpacingConstants.XXXL,
                ),
                const LoginWithEmailAndPasswordContainer(),
                const SizedBox(
                  height: SpacingConstants.M,
                ),
                const Divider(color: ColorConstants.BLUE_DARK),
                const SizedBox(height: SpacingConstants.M),
                LoginWithGoogleContainer(
                  onAuthenticate: () async {
                    await ref
                        .read(authenticateWithGoogleControllerProvider.notifier)
                        .onAuthenticate();
                  },
                ),
                const SizedBox(height: SpacingConstants.XS),

                TextButton(
                  onPressed: () {
                    context.navigateTo(const RegisterRoute());
                  },
                  child: const Text(
                    "Create account",
                    style: TextStyle(
                      color: ColorConstants.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // TODO for dev only
                // Divider(color: ColorConstants.BLUE_DARK.value),
                // ElevatedButton(
                //   onPressed: () async {
                //     ref.read(signOutControllerProvider.notifier).onSignOut();
                //   },
                //   child: const Text("Temp google signout"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAuthenticateWithGoogleControllerStateChange(
      AsyncValue<bool>? previous, AsyncValue<bool> next) {
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
      },
    );
  }
}
