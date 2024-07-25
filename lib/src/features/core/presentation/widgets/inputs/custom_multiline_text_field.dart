import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:flutter/material.dart';

class CustomMultilineTextField extends StatelessWidget {
  CustomMultilineTextField({
    super.key,
    required String label,
    required Color fillColor,
    required void Function(String) onChanged,
    int? maxLines,
    int? minLines,
    InputBorder? border,
    TextEditingController? textController,
    String? errorText,
  })  : _maxLines = maxLines ?? 5,
        _minLines = minLines ?? 5,
        _onChanged = onChanged,
        _label = label,
        _fillColor = fillColor,
        _border = border ?? InsideLabeledOutlineInputBorder.allRounded(),
        _textController = textController,
        _errorText = errorText;

  final int _maxLines;
  final int _minLines;
  final void Function(String) _onChanged;
  final String _label;
  final Color _fillColor;
  final InputBorder _border;
  final TextEditingController? _textController;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: _maxLines,
      minLines: _minLines,
      controller: _textController,
      onChanged: _onChanged,
      decoration: InputDecoration(
        border: _border,
        fillColor: _fillColor,
        filled: true,
        alignLabelWithHint: true,
        labelText: _label,
        errorText: _errorText,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
