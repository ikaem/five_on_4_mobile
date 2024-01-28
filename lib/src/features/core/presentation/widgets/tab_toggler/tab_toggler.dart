import 'package:flutter/material.dart';

// TODO write tests for this
// TODO use this instead of speciliazed widgets for tabs toggling

// TODO possibly can live elsewhere
class TabTogglerOptionValue {
  const TabTogglerOptionValue({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
}

class TabToggler extends StatefulWidget {
  const TabToggler({
    super.key,
    required this.options,
  });

  final List<TabTogglerOptionValue> options;

  @override
  State<TabToggler> createState() => _TabTogglerState();
}

class _TabTogglerState extends State<TabToggler>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.options.length,
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
    return Column(
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
          tabs: _generateTabs(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: generateTabChildren(),
          ),
        ),
      ],
    );
  }

  List<Tab> _generateTabs() {
    const selectorIndicator = " •";
    final currentTabIndex = _tabController.index;

    final List<Tab> tabs = [];

    for (int i = 0; i < widget.options.length; i++) {
      final currentOptionTitle = widget.options[i].title;
      final isSelected = i == currentTabIndex;

      final label = currentOptionTitle + (isSelected ? selectorIndicator : "");
      final tab = Tab(
        text: label,
      );

      tabs.add(tab);
    }

    return tabs;
  }

  List<Widget> generateTabChildren() {
    return widget.options.map((option) => option.child).toList();
  }
}
