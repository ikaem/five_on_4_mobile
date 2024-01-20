import 'package:flutter/material.dart';

class CurrentUserEventsWhenToggler extends StatefulWidget {
  const CurrentUserEventsWhenToggler({super.key});

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
          )
        ],
      ),
    );
  }
}
