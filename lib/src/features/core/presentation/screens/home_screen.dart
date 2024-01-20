// TODO dont forget to test this

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/provider/auth_status_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
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
  Widget build(
    BuildContext context,
    // WidgetRef ref,
  ) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text("Home Screen"),
            ElevatedButton(
              onPressed: () {
                // TODO make some extension to make sure "/" is added in front of the route automatically
                context.go("/${RoutePathsConstants.MATCH.value}");
              },
              child: const Text("Go to match"),
            ),
            ElevatedButton(
              onPressed: () {
                // ref.read(authStatusDataSourceProvider).setAuthDataStatus(null);
              },
              child: const Text("Logout"),
            ),
            // TODO start from here
            // TODO extract from here for eventWhenController
            Builder(builder: (context) {
              final isTodaySelected = _tabController.index == 0;

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
                          // child: Text,
                          // text: "Today",
                          child: Text(
                            "Today${isTodaySelected ? " •" : ""}",
                            // style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          text:
                              "Following matches${!isTodaySelected ? " •" : ""}",
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
