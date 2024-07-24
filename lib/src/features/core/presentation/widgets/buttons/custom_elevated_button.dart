import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

// TODO this should be
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.labelText,
    required this.onPressed,
    this.isFullWidth = true,
  });

  final Color buttonColor;
  final Color textColor;
  final String labelText;
  final bool isFullWidth;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize:
            isFullWidth ? Size(MediaQuery.of(context).size.width, 50) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // TODO use theme
        backgroundColor: buttonColor,
        foregroundColor: textColor,
      ),
      child: Text(labelText),
    );
  }
}
