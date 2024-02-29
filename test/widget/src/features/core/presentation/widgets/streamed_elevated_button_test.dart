import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/streamed_elevated_button.dart';

void main() {
  group(
    "$StreamedElevatedButton",
    () {
      group(
        ".onPressed()",
        () {
          testWidgets(
            "given provided stream emits 'false' value "
            "when the button is pressed "
            "then should NOT call provided onPressed callback",
            (widgetTester) async {
              // setup
              final onPressed = _MockOnPressedCallbackWrapper();

              // given
              final streamController = StreamController<bool>.broadcast();

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedElevatedButton(
                      isEnabledStream: streamController.stream,
                      onPressed: onPressed,
                      label: "Some label",
                    ),
                  ),
                ),
              );
              streamController.add(false);
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.byType(ElevatedButton));

              // then
              verifyNever(() => onPressed.call());

              addTearDown(() {
                streamController.close();
              });
            },
          );

          testWidgets(
            "given provided stream emits 'true' value "
            "when the button is pressed "
            "then should call provided onPressed callback",
            (widgetTester) async {
              // setup
              final onPressed = _MockOnPressedCallbackWrapper();

              // given
              final streamController = StreamController<bool>.broadcast();

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedElevatedButton(
                      isEnabledStream: streamController.stream,
                      onPressed: onPressed,
                      label: "Some label",
                    ),
                  ),
                ),
              );

              streamController.add(true);
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.byType(ElevatedButton));

              // then
              verify(() => onPressed.call()).called(1);

              addTearDown(() {
                streamController.close();
              });
            },
          );
        },
      );
    },
  );
}

class _MockOnPressedCallbackWrapper extends Mock {
  void call();
}
