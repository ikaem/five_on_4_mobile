import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:flutter/material.dart';

class StreamedTextField extends StatelessWidget {
  const StreamedTextField({
    super.key,
    required this.stream,
    required this.textController,
    required this.onChanged,
    required this.label,
  });

  final Stream<String> stream;
  final TextEditingController textController;
  final String label;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        final bool hasError = snapshot.hasError;
        // TODO figure out how to incorporate this
        final bool isEmptyInputError = snapshot.error == InputError.empty;

        return TextField(
          controller: textController,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
            errorText: hasError ? "This field is required" : null,
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
