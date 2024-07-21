import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
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
            TextField(
              // TODO check how to unify this styling with all other styles of streamed text fields
              decoration: InputDecoration(
                border: InsideLabeledOutlineInputBorder.topRounded(),
                filled: true,
                labelText: "EMAIL ADDRESS",
                // TODO use theme
                fillColor: ColorConstants.WHITE.value,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: InsideLabeledOutlineInputBorder.bottomRounded(),
                filled: true,
                // TODO use theme
                fillColor: ColorConstants.WHITE.value,
                labelText: "PASSWORD",
              ),
            ),
          ],
        ),
        SizedBox(
          height: SpacingConstants.M.value,
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
