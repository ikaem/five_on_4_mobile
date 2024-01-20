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

              final followingEventsSelectorUnselected =
                  find.text("Following matches");
              await widgetTester.tap(followingEventsSelectorUnselected);

              await widgetTester.pumpAndSettle();

              final todaySelector = find.text("Today $selectorIndicator");
              final followingEventsSelector =
                  find.text("Following matches $selectorIndicator");

              expect(todaySelector, findsNothing);
              expect(followingEventsSelector, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
