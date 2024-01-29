import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selectorIndicator = "•";

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
              final options = [
                TabTogglerOptionValue(
                  title: "Option 1",
                  child: Container(),
                ),
                TabTogglerOptionValue(
                  title: "Option 2",
                  child: Container(),
                ),
                TabTogglerOptionValue(
                  title: "Option 3",
                  child: Container(),
                ),
              ];

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: TabToggler(options: options),
                  ),
                ),
              );

              final tabBars =
                  widgetTester.widgetList(find.byType(Tab)).toList();

              expect(tabBars.length, options.length);
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
