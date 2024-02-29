import 'dart:async';

import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_date_time_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeBuildContext());
  });

  group(
    "$StreamedDateTimeField",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given required arguments are provided "
            "when the widget is rendered "
            "then should show expected StreamBuilder",
            (widgetTester) async {
              // setup
              const stream = Stream<DateTime>.empty();
              final textController = TextEditingController();
              final onTapSetter = _MockDateTimeInputOnTapSetter(
                onDateTimeChanged: (_) {},
              );

              when(() => onTapSetter.textController).thenReturn(textController);

              // given / when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedDateTimeField(
                      label: "Some label",
                      stream: stream,
                      onTapSetter: onTapSetter,
                    ),
                  ),
                ),
              );

              // then
              final streamBuilderFinder = find.byWidgetPredicate((widget) {
                if (widget is! StreamBuilder<DateTime?>) return false;
                if (widget.stream != stream) return false;

                return true;
              });

              expect(streamBuilderFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given required arguments are provided"
            "when the widget is rendered"
            "then should show expected TextField",
            (widgetTester) async {
              // setup
              const label = "Some label";
              final textController = TextEditingController();
              final onTapSetter = _MockDateTimeInputOnTapSetter(
                onDateTimeChanged: (_) {},
              );

              when(() => onTapSetter.textController).thenReturn(textController);

              // given / when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedDateTimeField(
                      label: label,
                      stream: const Stream<DateTime>.empty(),
                      onTapSetter: onTapSetter,
                    ),
                  ),
                ),
              );

              // then
              final inputFinder = find.byWidgetPredicate((widget) {
                if (widget is! TextField) return false;
                if (widget.controller != textController) return false;
                if (widget.readOnly != true) return false;
                if (widget.decoration?.labelText != label) return false;

                return true;
              });

              expect(inputFinder, findsOneWidget);

              addTearDown(() {
                textController.dispose();
              });
            },
          );
        },
      );
      group(
        ".onTap()",
        () {
          // test it calls provided on tap
          testWidgets(
            "given widget is rendered"
            "when tap on the input"
            "then should call DateTimeInputOnTapSetter.onTap",
            (widgetTester) async {
              // setup
              final textController = TextEditingController();
              final onTapSetter = _MockDateTimeInputOnTapSetter(
                onDateTimeChanged: (_) {},
              );

              // when(() => onTapSetter.onTap(any())).thenReturn(
              //   () => Future.value(),
              // );
              when(() => onTapSetter.onTap(any()))
                  .thenAnswer((invocation) async {});
              when(() => onTapSetter.textController).thenReturn(textController);

              // given
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedDateTimeField(
                      label: "Some label",
                      stream: const Stream<DateTime>.empty(),
                      onTapSetter: onTapSetter,
                    ),
                  ),
                ),
              );

              // when
              await widgetTester.tap(find.byType(StreamedDateTimeField));
              await widgetTester.pumpAndSettle();

              // then
              verify(() => onTapSetter.onTap(any())).called(1);

              addTearDown(() {
                textController.dispose();
              });
            },
          );

          // test that invalid value passed to onDateTimeChanged will show error message
          testWidgets(
            "given invalid DateTime is passed to onDateTimeChanged "
            "when onTap is called "
            "then should show error message",
            (widgetTester) async {
              // setup
              final textController = TextEditingController();
              final onTapSetter = _MockDateTimeInputOnTapSetter(
                onDateTimeChanged: (_) {},
              );
              final streamController = StreamController<DateTime>.broadcast();

              when(() => onTapSetter.textController).thenReturn(textController);

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedDateTimeField(
                      label: "Some label",
                      stream: streamController.stream,
                      onTapSetter: onTapSetter,
                    ),
                  ),
                ),
              );

              // given
              when(() => onTapSetter.onTap(any()))
                  .thenAnswer((invocation) async {
                // simulate invalid value causing error in stream
                streamController.addError("Invalid value");
              });

              // when
              await widgetTester.tap(find.byType(StreamedDateTimeField));
              await widgetTester.pumpAndSettle();

              // then
              final errorTextFinder = find.text("This field is required");

              expect(errorTextFinder, findsOneWidget);

              addTearDown(() {
                streamController.close();
                textController.dispose();
              });
            },
          );

          testWidgets(
            "given valid DateTime is passed to onDateTimeChanged "
            "when onTap is called "
            "then should not show error message",
            (widgetTester) async {
              // setup
              final textController = TextEditingController();
              final onTapSetter = _MockDateTimeInputOnTapSetter(
                onDateTimeChanged: (_) {},
              );
              final streamController = StreamController<DateTime>.broadcast();

              when(() => onTapSetter.textController).thenReturn(textController);

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: StreamedDateTimeField(
                      label: "Some label",
                      stream: streamController.stream,
                      onTapSetter: onTapSetter,
                    ),
                  ),
                ),
              );

              // given
              when(() => onTapSetter.onTap(any()))
                  .thenAnswer((invocation) async {
                // simulate valid value
                streamController.add(DateTime.now());
              });

              // when
              await widgetTester.tap(find.byType(StreamedDateTimeField));
              await widgetTester.pumpAndSettle();

              // then
              final errorTextFinder = find.text("This field is required");

              expect(errorTextFinder, findsNothing);

              addTearDown(() {
                streamController.close();
                textController.dispose();
              });
            },
          );
        },
      );
    },
  );
}

class _MockOnDateTimeChangedCallbackWrapper extends Mock {
  void call(DateTime? dateTime);
}

class _MockDateTimeInputOnTapSetter extends Mock
    implements DateTimeInputOnTapSetter {
  _MockDateTimeInputOnTapSetter({
    required this.onDateTimeChanged,
  });
  @override
  final void Function(DateTime? dateTime) onDateTimeChanged;
  // final TextEditingController textController;
  // Future<void> Function() onTap(BuildContext context);
}

class _FakeBuildContext extends Fake implements BuildContext {}
