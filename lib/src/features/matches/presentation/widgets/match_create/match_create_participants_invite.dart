import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_text_field.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

typedef OnPlayerSearch = Future<void> Function({
  required String playerIdentifier,
});

// TODO this should be reused in match participants
class MatchCreateParticipantsInvite extends StatelessWidget {
  const MatchCreateParticipantsInvite({
    super.key,
    required this.onInvitationAction,
    required this.foundPlayers,
    required this.onPlayerSearch,
  });

  final List<PlayerModel> foundPlayers;
  final OnPlayerSearch onPlayerSearch;
  final OnInvitationAction onInvitationAction;

  @override
  Widget build(BuildContext context) {
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
          child: _MatchCreateParticipantsInvitePlayersList(
            foundPlayers: foundPlayers,
            onInvitationAction: onInvitationAction,
          ),
        ),
      ],
    );
  }
}

// TODO possibly move this somewhere - and maybe reuse

class _MatchCreateParticipantsInvitePlayersList extends StatelessWidget {
  const _MatchCreateParticipantsInvitePlayersList({
    required this.foundPlayers,
    required this.onInvitationAction,
  });

  final List<PlayerModel> foundPlayers;
  final OnInvitationAction onInvitationAction;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_is_not_empty
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

        return MatchPlayerInvitation(
          player: foundPlayer,
          isAddedToMatchInvitations: false,
          onInvitationAction: onInvitationAction,
        );
      },
    );
  }
}
