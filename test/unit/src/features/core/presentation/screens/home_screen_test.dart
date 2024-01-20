import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "HomeScreen",
    () {
      // TODO do somehow ordering and position possibly - dont force it though
      // group("Screen layout", () {});
      group(
        "Toggle 'when' on events selector",
        () {
          testWidgets(
            "given user has performed no actions"
            "when screen is rendered"
            "should have 'Today' selector selected by default",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: HomeScreen(),
                ),
              );
              // TODO maybe byWidgetPredicate can be used
              final todaySelector = find.byWidget(
                const Text(
                  "Today •",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );

              // assert style and that it finds widget
              expect(todaySelector, findsOneWidget);
            },
          );

          // testWidgets(
          //   "given there is no events"
          //   "when tap on 'Today' tab"
          //   "should show expected 'No event today' message",
          //   (widgetTester) async {
          //     await widgetTester.pumpWidget(
          //       Container(),
          //     );
          //   },
          // );
        },
      );
    },
  );
}
