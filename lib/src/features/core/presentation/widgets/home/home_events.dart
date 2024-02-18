import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief_extended.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeEvents extends StatelessWidget {
  const HomeEvents({
    super.key,
    required this.matches,
  });

  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];

        return GestureDetector(
          onTap: () {
            // context.go(location)
            final path = "/${RoutePathsConstants.MATCH.value}" "/${match.id}";
            context.go(path);
          },
          child: MatchBriefExtended(
            date: match.date.toString(),
            // TODO make extension to format these properly
            dayName: "WEDNESDAY",
            time: "19:00",
            title: match.name,
            location: match.location,
            organizer: match.organizer,
            arrivingPlayersNumber: match.arrivingPlayers.length,
          ),
        );
      },
    );
  }
}
