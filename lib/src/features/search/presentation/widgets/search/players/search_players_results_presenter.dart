// TODO widget that will handle situations:
// - when loading
// - when error
// - when no matches found
// - when matches found
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/players_briefs_list.dart';
import 'package:flutter/material.dart';

// TODO this could possibly be resued with matches and layers - we would just pass it generic to know what data it should present

class SearchPlayersResultsPresenter extends StatelessWidget {
  const SearchPlayersResultsPresenter({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.players,
  });

  final bool isLoading;
  final bool isError;
  final List<PlayerModel> players;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const ErrorStatus(
        message: "There was an issue searching matches",
        onRetry: null,
        // onRetry: () async {
        //   // TODO for now do noting, dont offer it
        // },
      );
    }
    if (isLoading) {
      return const LoadingStatus(
        message: "Searching matches...",
      );
    }

    if (players.isEmpty) {
      return const Center(
        child: Text("No matches found"),
      );
    }

    return PlayersBriefsList(players: players);
  }
}
