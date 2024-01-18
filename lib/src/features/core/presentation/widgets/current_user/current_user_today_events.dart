import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief_extended.dart';
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

    return ListView.builder(
      itemCount: todaysMatches.length,
      itemBuilder: (context, index) {
        final match = todaysMatches[index];

        return MatchBriefExtended(
          date: match.date.toString(),
          // TODO make extension to format these properly
          dayName: "WEDNESDAY",
          time: "19:00",
          title: match.name,
          location: match.location,
          organizer: match.organizer,
          arrivingPlayers: match.arrivingPlayers,
        );
      },
    );
  }
}
