import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/screens/settings_screen/settings_screen_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SettingsScreenView(),
    );

    // ));
  }
}
