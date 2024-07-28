import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_text_field.dart';
import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

// TODO this will required bunch of text edit controllers later

class LoginWithEmailAndPasswordContainer extends StatefulWidget {
  const LoginWithEmailAndPasswordContainer({super.key});

  @override
  State<LoginWithEmailAndPasswordContainer> createState() =>
      _LoginWithEmailAndPasswordContainerState();
}

class _LoginWithEmailAndPasswordContainerState
    extends State<LoginWithEmailAndPasswordContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            CustomTextField(
              labelText: "EMAIL ADDRESS",
              fillColor: ColorConstants.WHITE,
              border: InsideLabeledOutlineInputBorder.topRounded(),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "PASSWORD",
              fillColor: ColorConstants.WHITE,
              shouldObscureText: true,
              border: InsideLabeledOutlineInputBorder.bottomRounded(),
            ),
          ],
        ),
        const SizedBox(
          height: SpacingConstants.M,
        ),
        // TODO integrate with StreamedElevatedButton
        CustomElevatedButton(
          buttonColor: ColorConstants.ORANGE,
          textColor: ColorConstants.WHITE,
          labelText: "Login",
          onPressed: () {},
        ),
      ],
    );
  }
}
