import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:flutter/material.dart';

class StreamedDateTimeField extends StatelessWidget {
  const StreamedDateTimeField({
    super.key,
    required this.stream,
    // required this.textController,
    required this.label,
    required this.onTapSetter,
    // required this.onTap,
  });

  final Stream<DateTime> stream;
  // final TextEditingController textController;
  final String label;
  // final VoidCallback onTap;
  final DateTimeInputOnTapSetter onTapSetter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime?>(
      stream: stream,
      builder: (context, snapshot) {
        final hasError = snapshot.hasError;

        return TextField(
          controller: onTapSetter.textController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: label,
            errorText: hasError ? "This field is required" : null,
          ),
          onTap: () => onTapSetter.onTap(context),
        );
      },
    );
  }
}
