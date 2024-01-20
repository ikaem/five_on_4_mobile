import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief_extended.dart';
import 'package:flutter/material.dart';

class CurrentUserEventsFollowing extends StatelessWidget {
  const CurrentUserEventsFollowing({
    super.key,
    required this.matches,
  });

  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const Column(
        children: [
          Text("No joined matches"),
          Text("Why not join one?"),
        ],
      );
    }

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];

        return MatchBrief(
          key: ValueKey(match.id),
          date: match.date.toString(),
          // TODO make extension to format these properly
          dayName: "WEDNESDAY",
          time: "19:00",
          title: match.name,
          location: match.location,
        );
      },
    );
  }
}
