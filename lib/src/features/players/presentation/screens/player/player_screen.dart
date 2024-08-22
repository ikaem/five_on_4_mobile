import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/screens/player/player_screen_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PlayerScreen extends StatelessWidget {
  const PlayerScreen({
    super.key,
    required this.playerId,
  });

  final int playerId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlayerScreenView(
        playerId: playerId,
      ),
    );
  }
}
