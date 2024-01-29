import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
import 'package:flutter/material.dart';

class MatchParticipants extends StatelessWidget {
  const MatchParticipants({
    super.key,
    required this.participants,
  });

  final List<PlayerModel> participants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];

        return PlayerBrief(
          avatarUri: participant.avatarUri,
          nickname: participant.nickname,
        );
      },
    );
  }
}
