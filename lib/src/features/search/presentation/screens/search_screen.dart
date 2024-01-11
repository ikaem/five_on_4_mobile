import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Text("Search Screen"),
          ElevatedButton(
            onPressed: () {
              // TODO has to have "/" in front of it to make sure it navigates to root/match - match is nested to make sure we have back button
              context.go("/${RoutePathsConstants.MATCH.value}");
            },
            child: const Text("Go to match"),
          ),
        ],
      ),
    ));
  }
}
