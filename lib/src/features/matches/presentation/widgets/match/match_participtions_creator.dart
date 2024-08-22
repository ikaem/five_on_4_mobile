// TODO THIS IS virtually same as in match creatze participations invire
// TODO it should be reused in both places, so create just one
// TODO name should also be changed - this does not really invite
// instead - this
// searches for players only
// and then we would pass callback for on tap player, or something - we can see in future

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_text_field.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

// TODO create a better name for this
class MatchParticipationsCreator extends StatelessWidget {
  const MatchParticipationsCreator({
    super.key,
    required this.matchId,
    // required this.players,
  });

  final int matchId;
  // final List<PlayerModel> players;

  @override
  Widget build(BuildContext context) {
    // TODO this should get provider for searching players
    // TODO make sure that this is not the same instance as in search players - maybe we should adjust it so it does not persist
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          labelText: "PLAYER NAME / NICKNAME",
          fillColor: ColorConstants.GREY_LIGHT,
        ),
        const SizedBox(height: SpacingConstants.M),
        const Divider(),
        const SizedBox(height: SpacingConstants.M),
        const Text(
          "FOUND PLAYERS",
          style: TextStyle(
            color: ColorConstants.BLUE_DARK,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: SpacingConstants.M),
        // Expanded(
        Flexible(
          flex: 1,
          // fit: FlexFit.loose,
          child: _MatchParticipationCreatorPlayersList(
            onPlayerTap: (player) {},
            foundPlayers: const [],
            // foundPlayers: foundPlayers,
            // onInvitationAction: onInvitationAction,
          ),
        ),
      ],
    );
  }
}

class _MatchParticipationCreatorPlayersList extends StatelessWidget {
  const _MatchParticipationCreatorPlayersList({
    super.key,
    required this.onPlayerTap,
    required this.foundPlayers,
  });

  final void Function(PlayerModel player) onPlayerTap;
  final List<PlayerModel> foundPlayers;

  @override
  Widget build(BuildContext context) {
    if (foundPlayers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: SpacingConstants.M),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO on search screen, make sure that no matches found is same way not in center, but closer to top
            Text(
              "No players found",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.BLACK,
                fontWeight: FontWeight.bold,
                fontSize: TextSizeConstants.LARGE,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: SpacingConstants.M),
      itemCount: foundPlayers.length,
      itemBuilder: (context, index) {
        final foundPlayer = foundPlayers[index];

        // return MatchPlayerInvitation(
        //   player: foundPlayer,
        //   isAddedToMatchInvitations: false,
        //   onInvitationAction: onInvitationAction,
        // );

        return MatchPlayerParticipation(
          player: foundPlayer,
          actions: const [],
        );
      },
    );
  }
}
