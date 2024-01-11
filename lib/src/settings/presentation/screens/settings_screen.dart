import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Text("Settings Screen"),
          ElevatedButton(
            onPressed: () {
              context.go(RoutePathsConstants.MATCH.value);
            },
            child: const Text("Go to match"),
          ),
        ],
      ),
    ));
  }
}
