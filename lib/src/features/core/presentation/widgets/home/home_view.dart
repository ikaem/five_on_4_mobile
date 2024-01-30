import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.matchesToday,
    required this.matchesFollowing,
  });

  final List<MatchModel> matchesToday;
  final List<MatchModel> matchesFollowing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeGreeting(
          nickName: "nickName",
          teamName: "teamName",
          avatarUrl: Uri.parse(
              "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
        ),
        Expanded(
          child: TabToggler(options: _togglerOptions),
        ),
      ],
    );
  }

  List<TabTogglerOptionValue> get _togglerOptions => [
        TabTogglerOptionValue(
          title: "Today",
          child: HomeEvents(
            matches: matchesToday,
          ),
        ),
        TabTogglerOptionValue(
          title: "Following matches",
          child: HomeEvents(
            matches: matchesFollowing,
          ),
        ),
      ];
}
