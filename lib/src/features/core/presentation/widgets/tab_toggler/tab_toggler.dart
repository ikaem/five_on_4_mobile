import 'package:five_on_4_mobile/src/style/utils/constants/circular_radius_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

// TODO write tests for this
// TODO use this instead of speciliazed widgets for tabs toggling

// TODO possibly can live elsewhere - but here might be fine because it belongs to this - maybe just delegate it to part and part of
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
    required this.backgroundColor,
  });

  final List<TabTogglerOptionValue> options;
  final Color backgroundColor;

  @override
  State<TabToggler> createState() => _TabTogglerState();
}

class _TabTogglerState extends State<TabToggler>
    with SingleTickerProviderStateMixin {
  // TODO tab controller might not be needed at all
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
    return Container(
      padding: const EdgeInsets.all(SpacingConstants.L),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: CircularRadiusConstants.REGULAR,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: SpacingConstants.XS),
          TabBar(
            controller: _tabController,
            dividerHeight: 0,
            labelColor: ColorConstants.BLACK,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            // TODO seems like no need to this
            // onTap: (value) {
            //   setState(() {});
            // },
            tabs: _tabs,
          ),
          const SizedBox(height: SpacingConstants.XXL),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: generateTabChildren(),
            ),
          ),
        ],
      ),
    );
  }

  List<Tab> get _tabs {
    final tabs = widget.options.map((e) => Tab(text: e.title)).toList();

    return tabs;
  }

  List<Widget> generateTabChildren() {
    return widget.options.map((option) => option.child).toList();
  }
}
