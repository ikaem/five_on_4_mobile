import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player/player_info.dart';
import 'package:flutter/material.dart';

class PlayerInfoContainer extends StatelessWidget {
  const PlayerInfoContainer({
    super.key,
    required this.isError,
    required this.isLoading,
    required this.player,
  });

  final PlayerModel? player;
  final bool isError;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const ErrorStatus(
        message: "There was an issue retrieving player",
        onRetry: null,
      );
    }

    if (isLoading) {
      return const LoadingStatus(
        message: "Loading player...",
      );
    }

    final thisPlayer = player;

    if (thisPlayer == null) {
      return const Center(
        // TODO style this
        // TODO do the same for match
        // TODO this should never happen
        child: Text("Player not found"),
      );
    }

    return PlayerInfo(
      player: thisPlayer,
    );
  }
}
