import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Match Screen"),
      ),
      body: Column(
        children: [
          const Text("Match Screen"),
          ElevatedButton(
            onPressed: () {
              context.go(RoutePathsConstants.ROOT.value);
            },
            child: const Text("Go to home"),
          ),
        ],
      ),
    ));
  }
}
