import 'package:five_on_4_mobile/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_invite.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchCreateParticipants extends StatelessWidget {
  const MatchCreateParticipants({
    super.key,
    required this.playersToInvite,
  });

  final List<PlayerModel> playersToInvite;

  @override
  Widget build(BuildContext context) {
    final invitePlayersButton = ElevatedButton(
      onPressed: () => _onShowParticipantsInviteDialog(context: context),
      child: const Text("Invite players"),
    );

    if (playersToInvite.isEmpty) {
      return Column(
        children: [
          const Text("No players have been invited to the match"),
          const Text("Why don’t you reach out to some?"),
          invitePlayersButton,
        ],
      );
    }

    return Column(
      children: [
        invitePlayersButton,
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
            foundPlayers: const [],
            // TODO this possibly does not need to be async - we will just have to set this value into rx subject
            onPlayerSearch: ({required String playerIdentifier}) async {},
          ),
        );
      },
    );
  }
}
