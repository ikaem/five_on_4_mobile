import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_when_toggler.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_greeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group(
    "HomeScreen",
    () {
      // TODO do somehow ordering and position possibly - dont force it though
      group(
        "Screen layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when screen is rendered"
            "should show all expected child widgets",
            (widgetTester) async {
              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  const MaterialApp(
                    home: HomeScreen(),
                  ),
                );
              });

              // TODO make sure to find specific widget with specific arguments passed to it
              // TODO also make sure to split tests into multiple tests for each widget
              final greetingWidget = find.byType(CurrentUserGreeting);
              final whenTogglerWidget =
                  find.byType(CurrentUserEventsWhenToggler);

              expect(whenTogglerWidget, findsOneWidget);
              expect(greetingWidget, findsOneWidget);
              print("what");
            },
          );
        },
      );
    },
  );
}
