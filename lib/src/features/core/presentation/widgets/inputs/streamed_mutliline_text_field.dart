import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_multiline_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class StreamedMultilineTextField extends StatelessWidget {
  const StreamedMultilineTextField({
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

        return CustomMultilineTextField(
          label: label,
          fillColor: ColorConstants.GREY,
          onChanged: onChanged,
          textController: textController,
        );

// TODO leave as is a for a bit
        // return TextField(
        //   maxLines: 5,
        //   minLines: 5,
        //   controller: textController,
        //   onChanged: onChanged,
        //   decoration: InputDecoration(
        //     border: InsideLabeledOutlineInputBorder.allRounded(),
        //     fillColor: ColorConstants.GREY,
        //     filled: true,
        //     alignLabelWithHint: true,
        //     labelText: label,
        //     errorText: hasError ? "This field is required" : null,
        //     errorStyle: const TextStyle(
        //       color: Colors.red,
        //     ),
        //   ),
        // );
      },
    );
  }
}
