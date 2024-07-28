import 'package:five_on_4_mobile/src/features/core/presentation/widgets/settings/settings_profile_items.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class SettingsProfileContainer extends StatelessWidget {
  const SettingsProfileContainer({
    super.key,
    required this.searchRadius,
    required this.onSearchRadiusChanged,
    required this.onLogout,
  });

  // TODO maybe containers should get their on riverpod cotnroller providerrs - we will see
  final double searchRadius;
  final void Function(double) onSearchRadiusChanged;
  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        SettingsProfileSearchRadiusItem(
          searchRadius: searchRadius,
          onSearchRadiusChanged: onSearchRadiusChanged,
        ),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        SettingsProfileLogoutItem(
          onLogout: onLogout,
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
      ],
    );
  }
}
