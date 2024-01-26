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
    if (playersToInvite.isEmpty) {
      return Column(
        children: [
          const Text("No players have been invited to the match"),
          const Text("Why don’t you reach out to some?"),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Invite players"),
          )
        ],
      );
    }

    return Container();
  }
}
