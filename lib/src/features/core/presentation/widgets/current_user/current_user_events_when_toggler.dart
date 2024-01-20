import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_following.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_today.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:flutter/material.dart';

class CurrentUserEventsWhenToggler extends StatefulWidget {
  const CurrentUserEventsWhenToggler({
    super.key,
    required this.matchesToday,
    required this.matchesFollowing,
  });

  final List<MatchModel> matchesToday;
  final List<MatchModel> matchesFollowing;

  @override
  State<CurrentUserEventsWhenToggler> createState() =>
      _CurrentUserEventsWhenTogglerState();
}

class _CurrentUserEventsWhenTogglerState
    extends State<CurrentUserEventsWhenToggler>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTodaySelected = _tabController.index == 0;
    const selectorIndicator = " •";

    return Container(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            onTap: (value) {
              setState(() {});
            },
            tabs: [
              Tab(
                child: Text(
                  "Today${isTodaySelected ? selectorIndicator : ""}",
                ),
              ),
              Tab(
                text:
                    "Following matches${!isTodaySelected ? selectorIndicator : ""}",
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CurrentUserEventsToday(
                  matches: widget.matchesToday,
                ),
                CurrentUserEventsFollowing(
                  matches: widget.matchesFollowing,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
