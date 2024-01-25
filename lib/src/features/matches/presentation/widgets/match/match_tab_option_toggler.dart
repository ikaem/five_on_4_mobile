import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_tab_option_participants.dart';
import 'package:flutter/material.dart';

class MatchTabOptionToggler extends StatefulWidget {
  const MatchTabOptionToggler({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  State<MatchTabOptionToggler> createState() => _MatchTabOptionTogglerState();
}

class _MatchTabOptionTogglerState extends State<MatchTabOptionToggler>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
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
    final isMatchInfoSelected = _tabController.index == 0;
    const selectorIndicator = " •";

    // return Container();

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
                  "Info${isMatchInfoSelected ? selectorIndicator : ""}",
                ),
              ),
              Tab(
                text:
                    "Participants${!isMatchInfoSelected ? selectorIndicator : ""}",
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MatchTabOptionInfo(
                  match: widget.match,
                ),
                MatchTabOptionParticipants(
                  participants: widget.match.arrivingPlayers,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
