import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_view.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  Widget build(BuildContext context) {
    final dummyMatch = MatchModel(
      id: 1,
      arrivingPlayers: const [],
      date: DateTime.now(),
      location: "location",
      name: "name",
      organizer: "organizer",
      description: "description",
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        // TODO views can potentially live in screen part
        body: MatchView(
          match: dummyMatch,
        ),
      ),
    );
  }
}
