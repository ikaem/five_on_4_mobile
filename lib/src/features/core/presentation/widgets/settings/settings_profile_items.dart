import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

class SettingsProfileLogoutItem extends StatelessWidget {
  const SettingsProfileLogoutItem({
    super.key,
    required this.onLogout,
  });

  final void Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      buttonColor: ColorConstants.BLUE_DARK,
      textColor: ColorConstants.WHITE,
      labelText: "LOG OUT",
      onPressed: onLogout,
    );
  }
}

class SettingsProfileSearchRadiusItem extends StatelessWidget {
  const SettingsProfileSearchRadiusItem({
    super.key,
    required this.searchRadius,
    required this.onSearchRadiusChanged,
  });

  final double searchRadius;
  final void Function(double) onSearchRadiusChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: TextSizeConstants.LARGE,
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(
                text: "SEARCH RADIUS: ",
                style: TextStyle(
                  color: ColorConstants.BLUE_DARK,
                ),
              ),
              TextSpan(
                text: "${searchRadius.toInt()} km",
                style: const TextStyle(
                  color: ColorConstants.BLACK,
                ),
              ),
            ],
          ),
        ),
        const Text(
          "This limits all search results to those active in the selected radius  from your current position",
          style: TextStyle(
            color: ColorConstants.GREY_DARK,
          ),
        ),
        Slider(
          value: searchRadius,
          min: 0.0,
          max: 200.0,
          activeColor: ColorConstants.GREY_DARK,
          thumbColor: ColorConstants.BLUE_DARK,
          onChanged: onSearchRadiusChanged,
        ),
      ],
    );
  }
}
