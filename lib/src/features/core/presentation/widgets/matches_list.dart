import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief_extended.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO this can be reused in search as well - so rename it to events list or something?
class MatchesList extends StatelessWidget {
  const MatchesList({
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
            // TODO no longer needed
            final path = "/${RoutePathsConstants.MATCH.value}" "/${match.id}";
            // context.go(path);
            context.navigateTo(MatchRoute(matchId: match.id));
          },
          child: MatchBriefExtended(
            // TODO format this properly
            date: match.dateAndTime.toIso8601String(),
            // TODO make extension to format these properly
            dayName: "WEDNESDAY",
            // TODO take time from dateTime
            time: "19:00",
            title: match.title,
            location: match.location,
            // TODO will need to migrate this to add organizer once backend provides
            // organizer: match.organizer,
            organizer: "Organizer",
            // TODO will need to migrate this to add organizer once backend provides
            arrivingPlayersNumber: 100,
          ),
        );
      },
    );
  }
}
