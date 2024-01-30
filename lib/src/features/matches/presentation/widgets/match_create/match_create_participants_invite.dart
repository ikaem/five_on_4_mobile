import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_participation/match_participation_invitation.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

typedef OnPlayerSearch = Future<void> Function({
  required String playerIdentifier,
});

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
    return Container(
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "PLAYER NAME / NICKNAME",
            ),
          ),
          const Text("FOUND PLAYERS"),
          Expanded(
            child: _MatchCreateParticipantsInvitePlayersList(
              foundPlayers: foundPlayers,
              onInvitationAction: onInvitationAction,
            ),
          ),
        ],
      ),
    );
  }
}

// TODO possibly move this somewhere

class _MatchCreateParticipantsInvitePlayersList extends StatelessWidget {
  const _MatchCreateParticipantsInvitePlayersList({
    required this.foundPlayers,
    required this.onInvitationAction,
  });

  final List<PlayerModel> foundPlayers;
  final OnInvitationAction onInvitationAction;

  @override
  Widget build(BuildContext context) {
    if (foundPlayers.isEmpty) {
      return const Text("No players found");
    }

    return ListView.builder(
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
