import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/sign_out/sign_out_controller.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/settings/settings_profile_container.dart';
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
        automaticallyImplyLeading: false,
        title: const Text("Settings"),
        backgroundColor: ColorConstants.BLUE_LIGHT,
        centerTitle: true,
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
