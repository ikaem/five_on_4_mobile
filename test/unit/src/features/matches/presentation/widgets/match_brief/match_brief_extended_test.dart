import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_brief/match_brief_extended.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchBriefExtended",
    () {
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
                home: MatchBriefExtended(
                  date: date,
                  dayName: dayName,
                  time: time,
                  title: "testTitle",
                  location: "testLocation",
                  organizer: "testOrganizer",
                  arrivingPlayersNumber: 0,
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

        testWidgets(
          "given title argument is provided"
          "when widget is rendered"
          "should show expected title",
          (widgetTester) async {
            const title = "testTitle";

            await widgetTester.pumpWidget(
              const MaterialApp(
                home: MatchBriefExtended(
                  date: "testDate",
                  dayName: "testDayName",
                  time: "testTime",
                  title: title,
                  location: "testLocation",
                  organizer: "testOrganizer",
                  arrivingPlayersNumber: 0,
                ),
              ),
            );

            final titleText = find.text(title);

            expect(titleText, findsOneWidget);
          },
        );

        testWidgets(
          "given location argument is provided"
          "when widget is rendered"
          "should show expected location",
          (widgetTester) async {
            const location = "testLocation";

            await widgetTester.pumpWidget(
              const MaterialApp(
                home: MatchBriefExtended(
                  date: "testDate",
                  dayName: "testDayName",
                  time: "testTime",
                  title: "testTitle",
                  location: location,
                  organizer: "testOrganizer",
                  arrivingPlayersNumber: 0,
                ),
              ),
            );

            final organizerText = find.text(location);

            expect(organizerText, findsOneWidget);
          },
        );

        testWidgets(
          "given organizer argument is provided"
          "when widget is rendered"
          "should show expected organizer text",
          (widgetTester) async {
            const organizer = "testOrganizer";

            await widgetTester.pumpWidget(
              const MaterialApp(
                home: MatchBriefExtended(
                  date: "testDate",
                  dayName: "testDayName",
                  time: "testTime",
                  title: "testTitle",
                  location: "testLocation",
                  organizer: organizer,
                  arrivingPlayersNumber: 0,
                ),
              ),
            );

            final organizerText = find.text("Organized by: $organizer");

            expect(organizerText, findsOneWidget);
          },
        );

        testWidgets(
          "given arrivingPlayers argument is provided"
          "when widget is rendered"
          "should show expected arriving players text",
          (widgetTester) async {
            const arrivingPlayers = 12;

            await widgetTester.pumpWidget(
              const MaterialApp(
                home: MatchBriefExtended(
                  date: "testDate",
                  dayName: "testDayName",
                  time: "testTime",
                  title: "testTitle",
                  location: "testLocation",
                  organizer: "testOrganizer",
                  arrivingPlayersNumber: arrivingPlayers,
                ),
              ),
            );

            final arrivingPlayersText =
                find.text("Arriving players: $arrivingPlayers");

            expect(arrivingPlayersText, findsOneWidget);
          },
        );
      });
    },
  );
}
