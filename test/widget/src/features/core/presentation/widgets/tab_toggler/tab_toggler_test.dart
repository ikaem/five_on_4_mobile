import 'dart:math';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";
  final options = [
    const TabTogglerOptionValue(
      title: "Option 1",
      child: Text("Content 1"),
    ),
    const TabTogglerOptionValue(
      title: "Option 2",
      child: Text("Content 2"),
    ),
    const TabTogglerOptionValue(
      title: "Option 3",
      child: Text("Content 3"),
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
                    body: TabToggler(
                      options: options,
                      backgroundColor: ColorConstants.WHITE,
                    ),
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
            "should render expected Tabs",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(
                      options: options,
                      backgroundColor: ColorConstants.WHITE,
                    ),
                  ),
                ),
              );

              final tabs =
                  widgetTester.widgetList<Tab>(find.byType(Tab)).toList();

              expect(tabs[0].text, "${options[0].title} $selectorIndicator");
              expect(tabs[1].text, options[1].title);
              expect(tabs[2].text, options[2].title);
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
                    body: TabToggler(
                      options: options,
                      backgroundColor: ColorConstants.WHITE,
                    ),
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

          testWidgets(
            "given a list of [TabTogglerOptionValue]s"
            "when widget is rendered"
            "should render expected widget in [TabBarView]",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(
                      options: options,
                      backgroundColor: ColorConstants.WHITE,
                    ),
                  ),
                ),
              );

              final content1Finder = find.descendant(
                of: find.byType(TabBarView),
                matching: find.text("Content 1"),
              );

              final content2Finder = find.descendant(
                of: find.byType(TabBarView),
                matching: find.text("Content 2"),
              );

              final content3Finder = find.descendant(
                of: find.byType(TabBarView),
                matching: find.text("Content 3"),
              );

              expect(content1Finder, findsOneWidget);
              expect(content2Finder, findsNothing);
              expect(content3Finder, findsNothing);
            },
          );
        },
      );

      group(
        "Tabbing",
        () {
          testWidgets(
            "given a tab is not selected"
            "when user taps on the tab"
            "should mark selected tab as active",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(
                      options: options,
                      backgroundColor: ColorConstants.WHITE,
                    ),
                  ),
                ),
              );

              const option2SelectedText = "Option 2 $selectorIndicator";
              const option1SelectedText = "Option 1 $selectorIndicator";

              final option2SelectorBeforeTouch = find.text(option2SelectedText);
              final option1SelectorBeforeTouch = find.text(option1SelectedText);

              expect(option2SelectorBeforeTouch, findsNothing);
              expect(option1SelectorBeforeTouch, findsOneWidget);

              await widgetTester.tap(find.text("Option 2"));
              await widgetTester.pumpAndSettle();

              final option2SelectorAfterTouch = find.text(option2SelectedText);
              final option1SelectorAfterTouch = find.text(option1SelectedText);

              expect(option2SelectorAfterTouch, findsOneWidget);
              expect(option1SelectorAfterTouch, findsNothing);
            },
          );

          testWidgets(
            "given a tab is not selected"
            "when user taps on the tab"
            "should render expected widget.",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(
                      options: options,
                      backgroundColor: ColorConstants.WHITE,
                    ),
                  ),
                ),
              );

              const content2SelectedText = "Content 2";
              const content1SelectedText = "Content 1";

              final content2FinderBeforeTouch = find.text(content2SelectedText);
              final content1FinderBeforeTouch = find.text(content1SelectedText);

              expect(content2FinderBeforeTouch, findsNothing);
              expect(content1FinderBeforeTouch, findsOneWidget);

              await widgetTester.tap(find.text("Option 2"));
              await widgetTester.pumpAndSettle();

              final content2FinderAfterTouch = find.text(content2SelectedText);
              final content1FinderAfterTouch = find.text(content1SelectedText);

              expect(content2FinderAfterTouch, findsOneWidget);
              expect(content1FinderAfterTouch, findsNothing);
            },
          );
        },
      );
    },
  );
}
