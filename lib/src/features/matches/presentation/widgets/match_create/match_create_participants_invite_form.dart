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
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "PLAYER NAME / NICKNAME",
            ),
          ),
          _MatchCreateParticipantsInviteFormPlayersList(
            foundPlayers: foundPlayers,
            onInvitationAction: onInvitationAction,
          ),
        ],
      ),
    );
  }
}

class _MatchCreateParticipantsInviteFormPlayersList extends StatelessWidget {
  const _MatchCreateParticipantsInviteFormPlayersList({
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

    return Container();
  }
}
