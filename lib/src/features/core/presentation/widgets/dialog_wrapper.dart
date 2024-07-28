import 'package:five_on_4_mobile/src/style/utils/constants/circular_radius_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

// TODO rename to CustomDialog
// TODO if there is need to add more dialogs then just in one screen, make it more generic
class DialogWrapper extends StatelessWidget {
  const DialogWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(SpacingConstants.M),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          CircularRadiusConstants.REGULAR,
        ),
      ),
      // TODO make color customizable eventually
      backgroundColor: ColorConstants.BLUE_LIGHT,
      child: Padding(
        padding: const EdgeInsets.all(SpacingConstants.M),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: TextSizeConstants.LARGE,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.BLUE_DARK,
                  ),
                ),
                SizedBox(
                  // TODO maybe these are constants too
                  height: 30,
                  width: 30,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: ColorConstants.BLUE_DARK,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: SpacingConstants.M,
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
