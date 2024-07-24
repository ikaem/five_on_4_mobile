import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player_brief/player_brief.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

class MatchParticipantsList extends StatelessWidget {
  const MatchParticipantsList({
    super.key,
    required this.participants,
  });

  final List<PlayerModel> participants;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: SpacingConstants.M,
      ),
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];

        return GestureDetector(
          onTap: () {
            // TODO in future, will be navigating to player profile
          },
          child: PlayerBrief(
            avatarUri: participant.avatarUri,
            nickname: participant.nickname,
          ),
        );
      },
    );
  }
}
