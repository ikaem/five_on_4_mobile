import 'dart:ui';

import 'package:five_on_4_mobile/src/style/inputs/no_border_side_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        ElevatedButton(
          child: const Text("Login"),
          onPressed: () {},
        )
      ],
    );
  }
}
