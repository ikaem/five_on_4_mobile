import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:flutter/material.dart';

class StreamedTextField extends StatelessWidget {
  const StreamedTextField({
    super.key,
    // required this.stream,
    // required this.textController,
    // required this.label,
    // required this.fillColor,
    // required this.onChanged,
    required Stream<String> stream,
    required TextEditingController textController,
    required String label,
    required Color fillColor,
    InputBorder? border,
    bool? shouldObscureText,
    void Function(String)? onChanged,
  })  : _stream = stream,
        _textController = textController,
        _label = label,
        _fillColor = fillColor,
        _border = border,
        _shouldObscureText = shouldObscureText,
        _onChanged = onChanged;

  final Stream<String> _stream;
  final TextEditingController _textController;
  final String _label;
  final Color _fillColor;
  final InputBorder? _border;
  final bool? _shouldObscureText;
  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _stream,
      builder: (context, snapshot) {
        final bool hasError = snapshot.hasError;
        // TODO figure out how to incorporate this
        final bool isEmptyInputError = snapshot.error == InputError.empty;

        return CustomTextField(
          onChanged: _onChanged,
          labelText: _label,
          fillColor: _fillColor,
          border: _border,
          shouldObscureText: _shouldObscureText,
          textController: _textController,
          errorText: hasError ? "This field is required" : null,
        );

        // TODO old, but keep here a bit longer
        // return TextField(
        //   controller: textController,
        //   onChanged: onChanged,
        //   decoration: InputDecoration(
        //     border: const OutlineInputBorder(),
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
