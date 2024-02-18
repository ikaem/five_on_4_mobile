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
    // final dummyMatch = MatchModel(
    //   id: 1,
    //   arrivingPlayers: const [],
    //   date: DateTime.now(),
    //   location: "location",
    //   name: "name",
    //   organizer: "organizer",
    //   description: "description",
    // );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: MatchScreenView(
          // match: dummyMatch,
          matchId: matchId,
        ),
      ),
    );
  }
}
