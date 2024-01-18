import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class CurrentUserTodayEvents extends StatelessWidget {
  const CurrentUserTodayEvents({
    super.key,
    required this.todaysMatches,
  });

  final List<MatchModel> todaysMatches;

  @override
  Widget build(BuildContext context) {
    if (todaysMatches.isEmpty) {
      return const Column(
        children: [
          Text("No matches today"),
          Text("Have a rest, you deserve it!"),
        ],
      );
    }

    return Container();
  }
}
