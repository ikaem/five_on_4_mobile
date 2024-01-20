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
          const selectorIndicator = "•";
          testWidgets(
            "given user has performed no actions"
            "when screen is rendered"
            "should have 'Today' selector selected by default, and not 'Following events'",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: HomeScreen(),
                ),
              );
              // TODO maybe byWidgetPredicate can be used
              // final todaySelector = find.byWidget(
              //   const Text(
              //     "Today •",
              //     // style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // );

              /* TODO this can be used as well */
              // final todaySelector = find.byWidgetPredicate(
              //   (widget) {
              //     if (widget is! Text) return false;
              //     if (widget.data != "Today •") return false;

              //     return true;
              //   },
              // );

              // assert style and that it finds widget
              final todaySelector = find.text("Today $selectorIndicator");
              final followingEventsSelector =
                  find.text("Following matches $selectorIndicator");

              expect(todaySelector, findsOneWidget);
              expect(followingEventsSelector, findsNothing);
            },
          );

          testWidgets(
            "given user selects 'following events'"
            "when screen is rendered"
            "should have 'Following' selector selected, and not 'Today'",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: HomeScreen(),
                ),
              );
              // TODO maybe byWidgetPredicate can be used
              // final todaySelector = find.byWidget(
              //   const Text(
              //     "Today •",
              //     // style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // );

              /* TODO this can be used as well */
              // final todaySelector = find.byWidgetPredicate(
              //   (widget) {
              //     if (widget is! Text) return false;
              //     if (widget.data != "Today •") return false;

              //     return true;
              //   },
              // );

              // assert style and that it finds widget
              final todaySelector = find.text("Today $selectorIndicator");
              final followingEventsSelector =
                  find.text("Following matches $selectorIndicator");

              expect(todaySelector, findsNothing);
              expect(followingEventsSelector, findsOneWidget);
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
