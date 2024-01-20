import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
import 'package:flutter/material.dart';

class MatchTabOptionParticipants extends StatelessWidget {
  const MatchTabOptionParticipants({super.key, required this.participants});

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

    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];

        return PlayerBrief(
          avatarUrl: participant.avatarUrl,
          nickname: participant.nickname,
        );
      },
    );
  }
}
