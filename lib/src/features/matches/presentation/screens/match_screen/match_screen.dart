import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen_view.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MatchScreenView(
        matchId: matchId,
      ),
    );
  }
}
