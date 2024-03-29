import 'package:five_on_4_mobile/src/features/core/utils/constants/core_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// AS PER nested route with shell route guide https://medium.com/@ahm4d.bilal/using-gorouters-shellroute-in-flutter-for-nested-navigation-777a9a20642f

// TODO this might also be an option https://docs.page/csells/go_router/nested-navigation

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return Scaffold(
      key: CoreScreensKeyConstants.MAIN_SCREEN.value,

      // key: UniqueKey(),
      // body: const Text(
      //   "Main Screen",
      // ),
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/${RoutePathsConstants.MATCH_CREATE.value}");
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onChangeTab,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  void _onChangeTab(int index) {
    switch (index) {
      case 0:
        context.go(RoutePathsConstants.ROOT.value);
        break;
      case 1:
        context.go(RoutePathsConstants.SEARCH.value);
        break;
      case 2:
        context.go(RoutePathsConstants.SETTINGS.value);
        break;
      default:
        // TODO navigate to home screen
        break;
    }

    setState(() {
      _currentIndex = index;
    });
  }
}
