import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_participants.dart';
import 'package:flutter/material.dart';

class MatchView extends StatelessWidget {
  const MatchView({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabToggler(
            options: _togglerOptions,
          ),
        ),
      ],
    );
  }

  List<TabTogglerOptionValue> get _togglerOptions => [
        TabTogglerOptionValue(
          title: "Info",
          child: MatchTabOptionInfo(
            match: match,
          ),
        ),
        TabTogglerOptionValue(
          title: "Participants",
          child: MatchTabOptionParticipants(
            participants: match.arrivingPlayers,
          ),
        ),
      ];
}
