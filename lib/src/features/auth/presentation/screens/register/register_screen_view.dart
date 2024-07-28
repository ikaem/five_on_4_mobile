// TODO in future, this probably will not need to be a consumer widget - but for now lets leave it
// TODO move to view file
import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/register/register_with_email_and_password_container.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreenView extends ConsumerWidget {
  const RegisterScreenView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO dont forget that register also logs in the user
    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,
      body: Padding(
        padding: const EdgeInsets.all(SpacingConstants.L),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(LocalAssetsPathConstants.LOGO_LARGE.value),
                const SizedBox(height: SpacingConstants.XXXL),
                const RegisterWithEmailAndPasswordContainer(),
                const SizedBox(height: SpacingConstants.M),
                TextButton(
                  onPressed: () {
                    context.navigateTo(const LoginRoute());
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: ColorConstants.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
