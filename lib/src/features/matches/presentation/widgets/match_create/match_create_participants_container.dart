import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';

class MatchCreateParticipantsContainer extends StatelessWidget {
  const MatchCreateParticipantsContainer({
    super.key,
    required this.playersToInvite,
  });

  final List<PlayerModel> playersToInvite;

  @override
  Widget build(BuildContext context) {
    return MatchCreateParticipants(playersToInvite: playersToInvite);
  }
}
