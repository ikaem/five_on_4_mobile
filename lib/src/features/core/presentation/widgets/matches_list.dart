import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief_extended.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';

// TODO this should possibly live in matches feature
// TODO this will probably be outdated - use MatchBriefsList
class MatchesList extends StatelessWidget {
  const MatchesList({
    super.key,
    required this.matches,
  });

  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: SpacingConstants.XL),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];

        return GestureDetector(
          onTap: () {
            context.navigateTo(MatchRoute(matchId: match.id));
          },
          child: MatchBriefExtended(
            match: match,
          ),
        );
      },
    );
  }
}
