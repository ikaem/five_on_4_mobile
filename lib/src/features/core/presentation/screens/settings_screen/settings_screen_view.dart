import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/sign_out/sign_out_controller.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreenView extends ConsumerStatefulWidget {
  const SettingsScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettingsScreenViewState();
}

class _SettingsScreenViewState extends ConsumerState<SettingsScreenView> {
// TODO temp states until we have a controller
// TODO maybe controller pvoidesr should live close to whatever consumes them

  double searchRadius = 60.0;
  void onSearchRadiusChanged(double value) {
    setState(() {
      searchRadius = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final togglerOptions = _getToggleOptions();

    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: ColorConstants.BLUE_LIGHT,
      ),
      body: TabToggler(
        options: togglerOptions,
        backgroundColor: ColorConstants.WHITE,
      ),
    );
  }

  List<TabTogglerOptionValue> _getToggleOptions() {
    return [
      TabTogglerOptionValue(
        title: "PROFILE",
        child: SettingsProfileContainer(
          searchRadius: searchRadius,
          onSearchRadiusChanged: onSearchRadiusChanged,
          onLogout: ref.read(signOutControllerProvider.notifier).onSignOut,
        ),
      ),
      const TabTogglerOptionValue(
        title: "GENERAL",
        child: Center(
          child: Text(
            "General settings",
            style: TextStyle(
              fontSize: TextSizeConstants.LARGE,
            ),
          ),
        ),
      ),
    ];
  }
}

// TODO move to its own file
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
        _SearchRadiusSettings(
          searchRadius: searchRadius,
          onSearchRadiusChanged: onSearchRadiusChanged,
        ),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        _LogoutSettings(
          onLogout: onLogout,
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
      ],
    );
  }
}

class _LogoutSettings extends StatelessWidget {
  const _LogoutSettings({
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

class _SearchRadiusSettings extends StatelessWidget {
  const _SearchRadiusSettings({
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
