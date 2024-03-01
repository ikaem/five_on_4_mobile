import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_date_time_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/extensions/date_time_extension.dart';
import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:flutter/material.dart';

class MatchCreateInfo extends StatelessWidget {
  const MatchCreateInfo({
    super.key,
    required TextEditingController nameController,
    required ValueSetter<String> onNameChanged,
    required Stream<String> nameStream,
    required TextEditingController dateTimeController,
    required ValueSetter<DateTime?> onDateTimeChanged,
    required Stream<DateTime> dateTimeStream,
  })  : _nameController = nameController,
        _onNameChanged = onNameChanged,
        _nameStream = nameStream,
        _dateTimeController = dateTimeController,
        _onDateTimeChanged = onDateTimeChanged,
        _dateTimeStream = dateTimeStream;

  // name
  final Stream<String> _nameStream;
  final TextEditingController _nameController;
  final ValueSetter<String> _onNameChanged;

  // date & time
  final Stream<DateTime> _dateTimeStream;
  final TextEditingController _dateTimeController;
  final ValueSetter<DateTime?> _onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    final dateTimeInputOnTapSetter = DateTimeInputOnTapSetter(
      initiallySelectedDate: DateTime.now().dayStart,
      fromDate: DateTime.now().dayStart,
      toDate: DateTime.now().add(const Duration(days: 365)).dayStart,
      onDateTimeChanged: _onDateTimeChanged,
      textController: _dateTimeController,
    );

    return Column(
      children: [
        StreamedTextField(
          stream: _nameStream,
          textController: _nameController,
          onChanged: _onNameChanged,
          label: "Match Name",
        ),
        const SizedBox(
          height: 10,
        ),
        StreamedDateTimeField(
          stream: _dateTimeStream,
          label: "Match Date & Time",
          onTapSetter: dateTimeInputOnTapSetter,
        ),
        const TextField(
          minLines: 5,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "MATCH DESCRIPTION",
          ),
        ),
      ],
    );
  }
}
