import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchParticipationInvitation extends StatelessWidget {
  const MatchParticipationInvitation({
    super.key,
    required this.player,
    required this.isAddedToMatchInvitations,
    required this.onInvitationAction,
  });

  final PlayerModel player;
  final bool isAddedToMatchInvitations;
  final void Function({
    required PlayerModel player,
  }) onInvitationAction;

  @override
  Widget build(BuildContext context) {
    final invitationIcon = isAddedToMatchInvitations
        ? const Icon(
            Icons.remove,
            color: Colors.green,
          )
        : const Icon(
            Icons.add,
            color: Colors.blue,
          );

    return Container(
      child: Row(
        children: [
          Container(
            child: Image.network(
              player.avatarUri.toString(),
              width: 54,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Text(
              player.nickname,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                onInvitationAction(
                  player: player,
                );
              },
              icon: invitationIcon,
            ),
          ),
        ],
      ),
    );
  }
}
