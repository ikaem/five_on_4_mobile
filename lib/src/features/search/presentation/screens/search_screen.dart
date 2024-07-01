import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@RoutePage()
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
            onPressed: () async {
              // TODO has to have "/" in front of it to make sure it navigates to root/match - match is nested to make sure we have back button
              // context.go("/${RoutePathsConstants.MATCH.value}");
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );

              if (date == null) return;

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),

                // initialDate: DateTime.now(),
                // firstDate: DateTime(2000),
                // lastDate: DateTime(2025),
              );
            },
            child: const Text("Go to match"),
          ),
        ],
      ),
    ));
  }
}
