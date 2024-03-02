import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Helper class to abstract the onTap logic for the DateTime input fields
///
/// It handles opening the date and time pickers, formatting the date and time
class DateTimeInputOnTapSetter extends Equatable {
  const DateTimeInputOnTapSetter({
    required this.initiallySelectedDate,
    required this.fromDate,
    required this.toDate,
    // TODO it might be better to use on success and on fail callback to abstract it all
    // but this is good too
    required this.onDateTimeChanged,
    required this.textController,
  });

  final DateTime initiallySelectedDate;
  final DateTime fromDate;
  final DateTime toDate;

  final ValueSetter<DateTime?> onDateTimeChanged;
  final TextEditingController textController;

  // Future<void> Function() onTap(BuildContext context) => () async {
  Future<void> onTap(BuildContext context) async {
    final localContext = context;

    final DateTime? pickedDate = await showDatePicker(
      context: localContext,
      initialDate: initiallySelectedDate,
      firstDate: fromDate,
      lastDate: toDate,
    );

    // TODO all of this needs to be tested
    if (pickedDate == null) {
      _resetSetters();
      return;
    }

    if (!localContext.mounted) {
      {
        _resetSetters();
        return;
      }
    }

    // now we have the date, let's get the time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: localContext,
      initialTime: TimeOfDay.fromDateTime(initiallySelectedDate),
    );

    if (pickedTime == null) {
      _resetSetters();
      return;
    }

    // assemble the date and time
    final DateTime picked = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (picked.isBefore(DateTime.now())) {
      _resetSetters();
      return;
    }

    // format the date and time
    // TODO put this format to constants
    final formattedDateTime =
        DateFormat('EEEE, MMMM d, yyyy, HH:mm').format(picked);

    onDateTimeChanged(picked);
    textController.text = formattedDateTime;
  }

  // Future<DateTime> pickDateTime() {
  //   return DateTime.now();
  // }

  void _resetSetters() {
    onDateTimeChanged(null);
    textController.text = "";
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        initiallySelectedDate,
        fromDate,
        toDate,
        onDateTimeChanged,
        textController,
      ];
}
