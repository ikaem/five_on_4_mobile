import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get dayStart {
    return DateTime(year, month, day);
  }

  String get dayNameString => DateFormat.EEEE().format(this);
  String get hourMinuteString => DateFormat.Hm().format(this);
  String get dateMonthString => DateFormat("dd MMM").format(this);
}
