import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_data.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchCreateTabOptionParticipants extends StatelessWidget {
  const MatchCreateTabOptionParticipants({
    super.key,
    required this.playersToInvite,
  });

  final List<PlayerModel> playersToInvite;

  @override
  Widget build(BuildContext context) {
    return MatchCreateParticipantsData(playersToInvite: playersToInvite);
  }
}
