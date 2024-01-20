import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief_extended.dart';
import 'package:flutter/material.dart';

class CurrentUserEventsToday extends StatelessWidget {
  const CurrentUserEventsToday({
    super.key,
    required this.matches,
  });

  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const Column(
        children: [
          Text("No matches today"),
          Text("Have a rest, you deserve it!"),
        ],
      );
    }

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];

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
