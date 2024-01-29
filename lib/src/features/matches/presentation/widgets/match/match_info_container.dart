import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info.dart';
import 'package:flutter/material.dart';

class MatchInfoContainer extends StatelessWidget {
  const MatchInfoContainer({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return MatchInfo(
      // TODO eventually, this needs only date in string
      date: match.date.toString(),
      // TODO this also needs valida data
      dayName: "dayName",
      time: "time",
      title: match.name,
      location: match.location,
      organizer: match.organizer,
      arrivingPlayersNumber: match.arrivingPlayers.length,
    );
  }
}
