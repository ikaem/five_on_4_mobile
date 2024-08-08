import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/match_briefs_list.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/matches_list.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
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

    return MatchBriefsList(
      matches: matches,
      onMatchTap: (context, match) {
        // TODO disable for now - while matches are fake
        // context.navigateTo(
        //   MatchRoute(matchId: match.id),
        // );
      },
    );
  }
}
