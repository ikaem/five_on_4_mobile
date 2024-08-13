import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    "$DateTimeInputOnTapSetter",
    () {
      group(
        ".onTap",
        () {
          testWidgets(
            "given an instance of DateTimeInputOnTapSetter "
            "when onTap is invoked "
            "then should show expected DatePickerDialog",
            (widgetTester) async {
              // setup
              final textEditingController =
                  TextEditingController(text: "some initial date value");
              final fromDate = DateTime.now();
              final toDate = DateTime.now().add(const Duration(days: 1));
              final initiallySelectedDate = DateTime.now();

              // given
              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textEditingController,
                fromDate: fromDate,
                toDate: toDate,
                initiallySelectedDate: initiallySelectedDate,
                onDateTimeChanged: (value) {},
              );

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // when
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              // then
              final datePickerDialogFinder = find.byWidgetPredicate((widget) {
                if (widget is! DatePickerDialog) return false;

                // TODO we can check these now and other fields
                final currentDate = widget.currentDate;
                final firstDate = widget.firstDate;
                final lastDate = widget.lastDate;

                final initiallySelectedDateStart = DateTime(
                  initiallySelectedDate.year,
                  initiallySelectedDate.month,
                  initiallySelectedDate.day,
                );
                final fromDateStart = DateTime(
                  fromDate.year,
                  fromDate.month,
                  fromDate.day,
                );
                final toDateStart = DateTime(
                  toDate.year,
                  toDate.month,
                  toDate.day,
                );

                if (currentDate != initiallySelectedDateStart) return false;
                if (firstDate != fromDateStart) return false;
                if (lastDate != toDateStart) return false;

                return true;
              });

              expect(datePickerDialogFinder, findsOneWidget);

              addTearDown(() {
                textEditingController.dispose();
              });
            },
          );
          testWidgets(
            "given onTap callback is invoked"
            "when no valid Date input is entered "
            "then should set controller to empty string",
            (widgetTester) async {
              // write the test

              // setup
              final textEditingController =
                  TextEditingController(text: "some initial date value");

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textEditingController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: DateTime.now(),
                onDateTimeChanged: (value) {},
              );
              // render the widget to get access to context
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.text("Cancel"));
              await widgetTester.pumpAndSettle();

              // then
              expect(textEditingController.text, equals(""));

              addTearDown(() {
                textEditingController.dispose();
              });
            },
          );

          testWidgets(
            "given onTap callback is invoked"
            "when no valid Date input is entered"
            "then should call onDateTimeChanged with null",
            (widgetTester) async {
              // setup
              final onDateTimeChanged = _MockOnDateTimeChangedCallbackWrapper();
              when(
                () => onDateTimeChanged(
                  any(),
                ),
              ).thenAnswer(
                (invocation) {},
              );

              final textController = TextEditingController();

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: DateTime.now(),
                onDateTimeChanged: onDateTimeChanged,
              );

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.text("Cancel"));
              await widgetTester.pumpAndSettle();

              // then
              verify(
                () => onDateTimeChanged(null),
              ).called(1);

              addTearDown(() {
                textController.dispose();
              });
            },
          );

          testWidgets(
            "given onTap callback is invoked"
            "when valid Date input is entered "
            "then should open expected TimePickerDialog",
            (widgetTester) async {
              // setup
              final textEditingController =
                  TextEditingController(text: "some initial date value");

              final initiallySelectedDate = DateTime.now();

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textEditingController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: initiallySelectedDate,
                onDateTimeChanged: (value) {},
              );
              // render the widget to get access to context
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              // when
              // TODO this will select already selected time - the initial time
              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              // then
              final timePickerDialogFinder = find.byWidgetPredicate((widget) {
                if (widget is! TimePickerDialog) return false;

                final initialTime = widget.initialTime;
                final initialTimeFromInitialDate = TimeOfDay.fromDateTime(
                  initiallySelectedDate,
                );

                if (initialTime != initialTimeFromInitialDate) return false;

                return true;
              });

              expect(timePickerDialogFinder, findsOneWidget);

              addTearDown(() {
                textEditingController.dispose();
              });
            },
          );

          testWidgets(
            "given TimePickerDialog is opened "
            "when invalid Time input is entered "
            "then should set controller to empty string",
            (widgetTester) async {
              // setup
              final textEditingController =
                  TextEditingController(text: "some initial date value");

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textEditingController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: DateTime.now(),
                onDateTimeChanged: (value) {},
              );

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.text("Cancel"));
              await widgetTester.pumpAndSettle();

              // then
              expect(textEditingController.text, equals(""));

              addTearDown(() {
                textEditingController.dispose();
              });
            },
          );

          testWidgets(
            "given TimePickerDialog is opened "
            "when invalid Time input is entered "
            "then should call onDateTimeChanged with null",
            (widgetTester) async {
              // setup
              final onDateTimeChanged = _MockOnDateTimeChangedCallbackWrapper();
              when(
                () => onDateTimeChanged(
                  any(),
                ),
              ).thenAnswer(
                (invocation) {},
              );

              final textController = TextEditingController();

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: DateTime.now(),
                onDateTimeChanged: onDateTimeChanged,
              );

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.text("Cancel"));
              await widgetTester.pumpAndSettle();

              // then
              verify(
                () => onDateTimeChanged(null),
              ).called(1);

              addTearDown(() {
                textController.dispose();
              });
            },
          );

          testWidgets(
            "given TimePickerDialog is opened "
            "when valid Time input is entered "
            "then should call onDateTimeChanged with the entered value",
            (widgetTester) async {
              // setup
              final onDateTimeChanged = _MockOnDateTimeChangedCallbackWrapper();
              when(
                () => onDateTimeChanged(
                  any(),
                ),
              ).thenAnswer(
                (invocation) {},
              );

              final textController = TextEditingController();

              final initialDate = DateTime.now();

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: initialDate,
                onDateTimeChanged: onDateTimeChanged,
              );

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              final expectedDateTime = DateTime(
                initialDate.year,
                initialDate.month,
                initialDate.day,
                initialDate.hour,
                initialDate.minute,
              );

              // then
              verify(
                () => onDateTimeChanged(
                  expectedDateTime,
                ),
              ).called(1);

              addTearDown(() {
                textController.dispose();
              });
            },
          );

          testWidgets(
            "given TimePickerDialog is opened "
            "when valid Time input is entered "
            "then should set controller to the entered value",
            (widgetTester) async {
              // setup
              final textEditingController =
                  TextEditingController(text: "some initial date value");

              final onTapSetter = DateTimeInputOnTapSetter(
                textController: textEditingController,
                fromDate: DateTime.now(),
                toDate: DateTime.now().add(const Duration(days: 1)),
                initiallySelectedDate: DateTime.now(),
                onDateTimeChanged: (value) {},
              );

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => onTapSetter.onTap(context),
                          child: const Text("Some button"),
                        );
                      },
                    ),
                  ),
                ),
              );

              // given
              await widgetTester.tap(find.byType(GestureDetector));
              await widgetTester.pumpAndSettle();

              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              // when
              await widgetTester.tap(find.text("OK"));
              await widgetTester.pumpAndSettle();

              // then
              final expectedDateTime = DateTime(
                onTapSetter.initiallySelectedDate.year,
                onTapSetter.initiallySelectedDate.month,
                onTapSetter.initiallySelectedDate.day,
                onTapSetter.initiallySelectedDate.hour,
                onTapSetter.initiallySelectedDate.minute,
              );

              expect(
                textEditingController.text,
                equals(
                  DateFormat('EEEE, MMMM d, yyyy, HH:mm').format(
                    expectedDateTime,
                  ),
                ),
              );

              addTearDown(() {
                textEditingController.dispose();
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
