// TODO dont forget to test this

import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Text("Home Screen"),
          ElevatedButton(
            onPressed: () {
              // TODO make some extension to make sure "/" is added in front of the route automatically
              context.go("/${RoutePathsConstants.MATCH.value}");
            },
            child: const Text("Go to match"),
          ),
        ],
      ),
    ));
  }
}
