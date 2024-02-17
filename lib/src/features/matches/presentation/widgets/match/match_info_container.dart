import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info.dart';
import 'package:flutter/material.dart';

class MatchInfoContainer extends StatelessWidget {
  const MatchInfoContainer({
    super.key,
    required this.match,
  });

  final MatchModel? match;

  @override
  Widget build(BuildContext context) {
    final thisMatch = match;

    // TODO checks go here

    if (thisMatch == null) {
      // TODO test this
      return const LoadingStatus(
        message: "Loading match...",
      );
    }

    return MatchInfo(
      // TODO eventually, this needs only date in string
      date: thisMatch.date.toString(),
      // TODO this also needs valida data
      dayName: "dayName",
      time: "time",
      title: thisMatch.name,
      location: thisMatch.location,
      organizer: thisMatch.organizer,
      arrivingPlayersNumber: thisMatch.arrivingPlayers.length,
    );
  }
}
