import 'package:five_on_4_mobile/src/features/core/presentation/widgets/matches_list.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class PlayerMatchesContainer extends StatelessWidget {
  const PlayerMatchesContainer(
      {super.key,
      required this.isError,
      required this.isLoading,
      required this.matches});

  final List<MatchModel> matches;
  final bool isError;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const Center(child: Text("No matches"));
    }

    return MatchesList(matches: matches);
  }
}
