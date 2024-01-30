import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "HomeEventsContainer",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given 'isToday' is true "
            "when widget is rendered "
            "should show expected 'NO MATCHES TODAY' message",
            (widgetTester) async {
              const isToday = true;

              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: HomeEventsContainer(
                      isToday: isToday,
                      matches: [],
                    ),
                  ),
                ),
              );

              final messageFinder = find.text("No matches today");
              final ctaFinder = find.text("Have a rest, you deserve it!");

              expect(messageFinder, findsOneWidget);
              expect(ctaFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
