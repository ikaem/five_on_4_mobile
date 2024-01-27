import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchCreateParticipantsData extends StatelessWidget {
  const MatchCreateParticipantsData({
    super.key,
    required this.playersToInvite,
  });

  final List<PlayerModel> playersToInvite;

  @override
  Widget build(BuildContext context) {
    final invitePlayersButton = ElevatedButton(
      onPressed: () {},
      child: const Text("Invite players"),
    );

    if (playersToInvite.isEmpty) {
      return Column(
        children: [
          const Text("No players have been invited to the match"),
          const Text("Why don’t you reach out to some?"),
          // TODO could extract this into build up top
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
}
