import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchCreateParticipantsContainer extends StatelessWidget {
  const MatchCreateParticipantsContainer({
    super.key,
    required this.playersToInvite,
    required this.isLoading,
    required this.isError,
    required this.onRetry,
  });

  final List<PlayerModel> playersToInvite;

  final bool isLoading;
  final bool isError;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    // TODO these need to be tested
    if (isError) {
      return ErrorStatus(
        message: "There was an issue creating match",
        onRetry: onRetry,
      );
    }

    if (isLoading) {
      return const LoadingStatus(
        message: "Creating match...",
      );
    }
    return MatchCreateParticipants(playersToInvite: playersToInvite);
  }
}
