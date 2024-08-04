import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

// TODO test this
class PlayersBriefsList extends StatelessWidget {
  const PlayersBriefsList({
    super.key,
    required this.players,
  });

  final List<PlayerModel> players;

  // TODO this could later, in different ticket when we add participants, actually accept some action widget, with icon and stuff, so we can invite player maybe?

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: SpacingConstants.XL),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];

        return GestureDetector(
          onTap: () {
            // TODO come back to this? or maybe we dont want this to be tappable by default? we could pass either on tapped, or let client wrap it in a gesture detector?
            // context.navigateTo(MatchRoute(matchId: match.id));
          },
          child: PlayerBrief(player: player),
        );
      },
    );
  }
}
