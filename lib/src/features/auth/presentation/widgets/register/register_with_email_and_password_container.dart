import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_text_field.dart';
import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class RegisterWithEmailAndPasswordContainer extends StatelessWidget {
  const RegisterWithEmailAndPasswordContainer({super.key});

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
              border: InsideLabeledOutlineInputBorder.allRounded(),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "FIRST NAME",
              fillColor: ColorConstants.WHITE,
              border: InsideLabeledOutlineInputBorder.allRounded(),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "LAST NAME",
              fillColor: ColorConstants.WHITE,
              border: InsideLabeledOutlineInputBorder.allRounded(),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "NICKNAME",
              fillColor: ColorConstants.WHITE,
              border: InsideLabeledOutlineInputBorder.allRounded(),
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
          labelText: "Register",
          onPressed: () {},
        ),
      ],
    );
  }
}
