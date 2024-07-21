import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class LoginWithGoogleContainer extends StatelessWidget {
  const LoginWithGoogleContainer({
    super.key,
    required this.onAuthenticate,
  });

  final Future<void> Function() onAuthenticate;

// TODO this widget needs to be tested that it has correct stuff

// TODO will also need to test login screen
  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   onPressed: onAuthenticate,
    //   child: const Text("Login with Google"),
    // );

    return CustomElevatedButton(
      buttonColor: ColorConstants.BLUE_DARK,
      textColor: ColorConstants.WHITE,
      labelText: "Login with Google",
      onPressed: onAuthenticate,
    );
  }
}
