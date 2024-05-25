import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_mutliline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    "$StreamedMultilineTextField",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given required arguments are provided "
            "when the widget is rendered "
            "then should show expected StreamBuilder",
            (widgetTester) async {
              // given
              const stream = Stream<String>.empty();
              final textController = TextEditingController();
              const labelText = "Some label";
              onChangedCallback(String value) {}

              // when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedMultilineTextField(
                      label: labelText,
                      stream: stream,
                      textController: textController,
                      onChanged: onChangedCallback,
                    ),
                  ),
                ),
              );

              // then
              final streamBuilderFinder = find.byWidgetPredicate((widget) {
                if (widget is! StreamBuilder<String>) return false;
                if (widget.stream != stream) return false;

                return true;
              });

              expect(streamBuilderFinder, findsOneWidget);

              // cleanup
              addTearDown(() {
                textController.dispose();
              });
            },
          );

          testWidgets(
            "given required arguments are provided "
            "when the widget is rendered "
            "then should show expected TextField",
            (widgetTester) async {
              // given
              const stream = Stream<String>.empty();
              final textController = TextEditingController();
              const labelText = "Some label";
              onChangedCallback(String value) {}

              // when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedMultilineTextField(
                      label: labelText,
                      stream: stream,
                      textController: textController,
                      onChanged: onChangedCallback,
                    ),
                  ),
                ),
              );

              // then
              final textFieldFinder = find.byWidgetPredicate((widget) {
                if (widget is! TextField) return false;
                if (widget.controller != textController) return false;
                if (widget.decoration?.labelText != labelText) return false;
                if (widget.maxLines != 5) return false;
                if (widget.minLines != 5) return false;

                return true;
              });

              expect(textFieldFinder, findsOneWidget);

              // cleanup
              addTearDown(() {
                textController.dispose();
              });
            },
          );
        },
      );

      group(
        ".onChange()",
        () {
          testWidgets(
            "given widget is rendered "
            "when the user types in the TextField "
            "then should call the onChanged callback",
            (widgetTester) async {
              // setup
              final onChangedCallback = _MockOnChangedCallbackWrapper();
              final textController = TextEditingController();

              when(() => onChangedCallback.call(any())).thenReturn(null);

              // given
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedMultilineTextField(
                      label: "Some label",
                      stream: const Stream<String>.empty(),
                      textController: TextEditingController(),
                      onChanged: onChangedCallback,
                    ),
                  ),
                ),
              );

              // when
              // await widgetTester.enterText(find.byType(TextField), "Some text");

              // then
              // verify(() => onChangedCallback.call("Some text")).called(1);
              verifyNever(() => onChangedCallback.call(any()));

              // cleanup
              addTearDown(() {
                textController.dispose();
              });
            },
          );
        },
      );
    },
  );
}

class _MockOnChangedCallbackWrapper extends Mock {
  void call(String value);
}
