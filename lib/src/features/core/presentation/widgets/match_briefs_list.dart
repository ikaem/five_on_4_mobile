import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class MatchBriefsList extends StatelessWidget {
  const MatchBriefsList({
    super.key,
    required this.matches,
    required this.onMatchTap,
  });

  final List<MatchModel> matches;
  final void Function(
    BuildContext context,
    MatchModel match,
  ) onMatchTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final match = matches[index];

        return GestureDetector(
          onTap: () => onMatchTap(
            context,
            match,
          ),
          child: MatchBrief(
            match: match,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: SpacingConstants.XL,
        child: Divider(),
      ),
      itemCount: matches.length,
    );
  }
}
