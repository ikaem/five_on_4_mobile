import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_following.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_today.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_greeting.dart';
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
        CurrentUserGreeting(
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
          child: CurrentUserEventsToday(
            matches: matchesToday,
          ),
        ),
        TabTogglerOptionValue(
          title: "Following matches",
          child: CurrentUserEventsFollowing(
            matches: matchesFollowing,
          ),
        ),
      ];
}
