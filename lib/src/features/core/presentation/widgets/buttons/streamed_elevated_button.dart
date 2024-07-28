import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class StreamedElevatedButton extends StatelessWidget {
  const StreamedElevatedButton({
    super.key,
    required this.isEnabledStream,
    required this.onPressed,
    required this.label,
  });

  final Stream<bool> isEnabledStream;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isEnabledStream,
      builder: (context, snapshot) {
        final isError = snapshot.hasError;
        final isEnabled = !isError && snapshot.data == true;

        return CustomElevatedButton(
          buttonColor: ColorConstants.GREY_DARK,
          textColor: ColorConstants.WHITE,
          labelText: "SEARCH",
          onPressed: isEnabled ? onPressed : null,
        );
      },
    );
  }
}
