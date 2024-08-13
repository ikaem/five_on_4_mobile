import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_invite.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

// TODO there is a problem here - when dialog is shown, all data is lost on info screen - create ticket for this
// TODO it seems that either text controllers are disposed of, or maybe match create input controller is disposed of - or something
class MatchCreateParticipants extends StatelessWidget {
  const MatchCreateParticipants({
    super.key,
    required this.playersToInvite,
  });

  final List<PlayerModel> playersToInvite;

  @override
  Widget build(BuildContext context) {
    // final invitePlayersButton = ElevatedButton(
    //   onPressed: () => _onShowParticipantsInviteDialog(context: context),
    //   child: const Text("Invite players"),
    // );

    if (playersToInvite.isEmpty) {
      return Column(
        children: [
          const Text(
            "No players have been invited to the match",
            style: TextStyle(
              fontSize: TextSizeConstants.EXTRA_LARGE,
              color: ColorConstants.BLUE_DARK,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpacingConstants.XS),
          const Text(
            "Why don’t you reach out to some?",
            style: TextStyle(
              fontSize: TextSizeConstants.LARGE,
              color: ColorConstants.BLACK,
            ),
          ),
          const SizedBox(height: SpacingConstants.L),
          // TODO this could potentially be a sheet - maybe no need to be a dialog
          CustomElevatedButton(
            buttonColor: ColorConstants.BLUE_DARK,
            textColor: ColorConstants.WHITE,
            labelText: "INVITE PLAYERS",
            onPressed: () => _onShowParticipantsInviteDialog(context: context),
          ),
        ],
      );
    }

    return Column(
      children: [
        // TODO this will need button to add new players
        // invitePlayersButton,

        Expanded(
          child: ListView.builder(
            itemCount: playersToInvite.length,
            itemBuilder: (context, index) {
              final playerToInvite = playersToInvite[index];

              return MatchPlayerInvitation(
                player: playerToInvite,
                isAddedToMatchInvitations: true,
                onInvitationAction: ({
                  required PlayerModel player,
                }) {
                  // TODO should do some stuff - not sure where is this going to be passed from
                },
              );
            },
          ),
        ),
      ],
    );
  }

// TODO create ticket for this to add feature to invite players to a match
  Future<void> _onShowParticipantsInviteDialog({
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogWrapper(
          title: "INVITE PLAYERS",
          child: MatchCreateParticipantsInvite(
            onInvitationAction: ({required PlayerModel player}) {},
            // foundPlayers: const [],
            // TODO temp for now
            foundPlayers: _tempFoundPlayers,
            // TODO this possibly does not need to be async - we will just have to set this value into rx subject
            onPlayerSearch: ({required String playerIdentifier}) async {},
          ),
        );
      },
    );
  }
}

final _tempFoundPlayers = List.generate(
  12,
  (index) => PlayerModel(
    avatarUri: Uri.parse(
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    id: index,
    name: "Player $index",
    nickname: "Nickname $index",
  ),
);
