import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/sign_out/sign_out_controller.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/settings_screen/settings_screen_view.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SettingsScreenView(),
    );

    // return SafeArea(
    //     child: Scaffold(
    //   body: Column(
    //     children: [
    //       const Text("Settings Screen"),

    //       // TODO move this to elsewhere
    //       TextButton(
    //         onPressed: () async =>
    //             await ref.read(signOutControllerProvider.notifier).onSignOut(),
    //         child: const Text("Logout"),
    //       ),
    //     ],
    //   ),
    // ));
  }
}

// TODO move to match screen view

