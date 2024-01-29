import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";
  final options = [
    TabTogglerOptionValue(
      title: "Option 1",
      child: Container(),
    ),
    const TabTogglerOptionValue(
      title: "Option 2",
      child: Row(),
    ),
    const TabTogglerOptionValue(
      title: "Option 3",
      child: Column(),
    ),
  ];

  group(
    "TabToggler",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given a list of [TabTogglerOptionValue]s"
            "when widget is rendered"
            "should render a [TabBar] with the same number of tabs as the list of [TabTogglerOptionValue]s",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(options: options),
                  ),
                ),
              );

              final tabBarFinder = find.byWidgetPredicate((widget) {
                if (widget is! TabBar) return false;
                if (widget.tabs.length != options.length) return false;

                return true;
              });

              expect(tabBarFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given a list of [TabTogglerOptionValue]s"
            "when widget is rendered"
            "should render a [TabBarView] with the same number of children as the list of [TabTogglerOptionValue]s",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(options: options),
                  ),
                ),
              );

              final tabBarViewFinder = find.byWidgetPredicate((widget) {
                if (widget is! TabBarView) return false;
                if (widget.children.length != options.length) return false;

                return true;
              });

              expect(tabBarViewFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        "Tabbing",
        () {},
      );
    },
  );
}
