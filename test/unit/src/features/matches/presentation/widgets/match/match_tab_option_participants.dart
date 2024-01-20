import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MatchTabOptionParticipants", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given empty list of participants is provided"
          "when widget is rendered"
          "should show expected NO PARTICIPANTS text",
          (widgetTester) async {
            final participants = <PlayerModel>[];

            await widgetTester.pumpWidget(
              MaterialApp(
                home: MatchTabOptionParticipants(
                  participants: participants,
                ),
              ),
            );

            final noParticipantsText = find.text("No participants");
            final inviteOneText = find.text("Why not invite one?");

            expect(noParticipantsText, equals(findsOneWidget));
            expect(inviteOneText, equals(findsOneWidget));
          },
        );
      },
    );
  });
}
