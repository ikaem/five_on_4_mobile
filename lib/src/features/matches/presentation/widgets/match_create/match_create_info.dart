import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:flutter/material.dart';

class MatchCreateInfo extends StatelessWidget {
  const MatchCreateInfo({
    super.key,
    required TextEditingController nameController,
    required ValueSetter<String> onNameChanged,
    required Stream<String> nameStream,
    required TextEditingController dateTimeController,
    required ValueSetter<DateTime> onDateTimeChanged,
    required Stream<String> dateTimeStream,
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
  final Stream<String> _dateTimeStream;
  final TextEditingController _dateTimeController;
  final ValueSetter<DateTime> _onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
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

        // StreamedTextField(
        //   stream: _dateTimeStream,
        //   textController: _dateTimeController,
        //   onChanged: _onDateTimeChanged,
        //   label: "Match Date & Time",
        // ),

        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "MATCH DATE AND TIME",
          ),
        ),
        // TextField(
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(),
        //     labelText: "MATCH TIME",
        //   ),
        // ),
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
