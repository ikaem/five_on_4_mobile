import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({
    super.key,
    required this.player,
  });

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CircleAvatar(
          // TODO leave as is for now
          radius: 100,
          backgroundImage: NetworkImage(
            player.avatarUri.toString(),
          ),
        ),
        const SizedBox(height: SpacingConstants.L),
        Text(
          player.nickname,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: TextSizeConstants.EXTRA_LARGE,
          ),
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: TextSizeConstants.LARGE,
            ),
            children: [
              const TextSpan(
                text: "Name: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: player.name,
              ),
            ],
          ),
        ),
        const SizedBox(height: SpacingConstants.S),
        const Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: TextSizeConstants.LARGE,
            ),
            children: [
              TextSpan(
                text: "Team: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Team to be implemented",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
