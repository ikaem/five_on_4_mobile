import 'dart:async';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "$StreamedTextField",
    () {
      // TODO need more and better tests here still
      group(
        ".onChanged()",
        () {
          testWidgets(
            "given an onChanged callback is provided "
            "when valid input is entered "
            "then should NOT show error message",
            (widgetTester) async {
              final streamController = StreamController<String>.broadcast();
              final textController = TextEditingController();

              const newValue = "newValue";

              final stream = streamController.stream;

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedTextField(
                      label: "Some label",
                      stream: stream,
                      onChanged: (value) {
                        streamController.add(value);
                      },
                      textController: textController,
                    ),
                  ),
                ),
              );

              await widgetTester.enterText(find.byType(TextField), newValue);
              await widgetTester.pumpAndSettle();

              final errorTextFinder = find.text("This field is required");
              expect(errorTextFinder, findsNothing);

              addTearDown(
                () {
                  streamController.close();
                  textController.dispose();
                },
              );
            },
          );

          testWidgets(
            "given an onChanged callback is provided "
            "when invalid input is entered "
            "then should show expected error message",
            (widgetTester) async {
              final streamController = StreamController<String>.broadcast();
              final textController = TextEditingController();

              final stream = streamController.stream;

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedTextField(
                      stream: stream,
                      onChanged: (value) {
                        // simulate validation
                        streamController.addError("Invalid value");
                      },
                      textController: textController,
                      label: "Some label",
                    ),
                  ),
                ),
              );

              await widgetTester.enterText(find.byType(TextField), "Some text");
              await widgetTester.pumpAndSettle();

              final errorTextFinder = find.text("This field is required");
              expect(errorTextFinder, findsOneWidget);

              addTearDown(
                () {
                  streamController.close();
                  textController.dispose();
                },
              );
            },
          );
        },
      );
      // test label
      // test controller has correct value
      // test onChanged is called
    },
  );
}
