import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchParticipantsContainer extends StatelessWidget {
  const MatchParticipantsContainer({super.key, required this.participants});

// TODO possible that we would need to introduce a model for participant
  final List<PlayerModel> participants;

  @override
  Widget build(BuildContext context) {
    if (participants.isEmpty) {
      return const Column(
        children: [
          Text("No participants"),
          Text("Why not invite some?"),
        ],
      );
    }

    return MatchParticipants(participants: participants);
  }
}
