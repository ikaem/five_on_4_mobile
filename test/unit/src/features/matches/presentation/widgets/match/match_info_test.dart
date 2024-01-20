import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MatchInfo", () {
    group("Layout", () {
      testWidgets(
        "given date, day name, and time arguments are provided"
        "when widget is rendered"
        "should show expected date, day name, and time",
        (widgetTester) async {
          const date = "23 DEC";
          const dayName = "WEDNESDAY";
          const time = "19:00";

          await widgetTester.pumpWidget(
            const MaterialApp(
              home: MatchInfo(
                date: date,
                dayName: dayName,
                time: time,
                title: "testTitle",
                location: "testLocation",
                organizer: "testOrganizer",
                arrivingPlayers: 0,
              ),
            ),
          );

          final dateText = find.text(date);
          final dayNameText = find.text(dayName);
          final timeText = find.text(time);

          expect(dateText, findsOneWidget);
          expect(dayNameText, findsOneWidget);
          expect(timeText, findsOneWidget);
        },
      );
    });
  });
}
