import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_toggler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyMatch = MatchModel(
      id: 1,
      arrivingPlayers: [],
      date: DateTime.now(),
      location: "location",
      name: "name",
      organizer: "organizer",
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // const Text("Match Screen"),
          // ElevatedButton(
          //   onPressed: () {
          //     context.go(RoutePathsConstants.ROOT.value);
          //   },
          //   child: const Text("Go to home"),
          // ),

          Expanded(
            child: MatchTabOptionToggler(
              match: dummyMatch,
            ),
          ),
        ],
      ),
    ));
  }
}
