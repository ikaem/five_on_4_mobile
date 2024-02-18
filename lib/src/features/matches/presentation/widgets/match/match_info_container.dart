import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info.dart';
import 'package:flutter/material.dart';

// TODO this needs to be tested for other fields too
class MatchInfoContainer extends StatelessWidget {
  const MatchInfoContainer({
    super.key,
    required this.match,
    required this.isError,
    required this.isLoading,
    required this.isSyncing,
    required this.onRetry,
  });

  final MatchModel? match;
  final bool isError;
  final bool isSyncing;
  final bool isLoading;

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return ErrorStatus(
        message: "There was an issue retrieving match",
        onRetry: onRetry,
      );
    }

    if (isLoading) {
      return const LoadingStatus(
        message: "Loading match...",
      );
    }

    final thisMatch = match;
    if (thisMatch == null) {
      return const LoadingStatus(
        message: "Loading match...",
      );
    }

    return Column(
      children: [
        Expanded(
          child: MatchInfo(
            // TODO pass entire match here eventually
            // TODO eventually, this needs only date in string
            date: thisMatch.date.toString(),
            // TODO this also needs valida data
            dayName: "dayName",
            time: "time",
            title: thisMatch.name,
            location: thisMatch.location,
            organizer: thisMatch.organizer,
            arrivingPlayersNumber: thisMatch.arrivingPlayers.length,
          ),
        ),
        if (isSyncing)
          const LoadingStatus(
            message: "Synchronizing with remote data...",
            isLinear: true,
          ),
      ],
    );
  }
}
