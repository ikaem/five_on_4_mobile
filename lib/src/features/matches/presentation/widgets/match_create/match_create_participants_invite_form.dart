import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

typedef OnPlayerSearch = Future<void> Function({
  required String playerIdentifier,
});

class MatchCreateParticipantsInviteForm extends StatelessWidget {
  const MatchCreateParticipantsInviteForm({
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
    return Container(
      child: const Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "PLAYER NAME / NICKNAME",
            ),
          ),
        ],
      ),
    );
  }
}
