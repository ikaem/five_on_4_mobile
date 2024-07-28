import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required String labelText,
    required Color fillColor,
    InputBorder? border,
    bool? shouldObscureText,
    TextEditingController? textController,
    String? errorText,
    void Function(String)? onChanged,
  })  : _labelText = labelText,
        _fillColor = fillColor,
        _border = border ?? InsideLabeledOutlineInputBorder.allRounded(),
        _shouldObscureText = shouldObscureText ?? false,
        _textController = textController,
        _errorText = errorText,
        _onChanged = onChanged;

  final bool _shouldObscureText;
  final String _labelText;
  final Color _fillColor;
  final InputBorder _border;
  final TextEditingController? _textController;
  final String? _errorText;
  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: _onChanged,
      obscureText: _shouldObscureText,
      decoration: InputDecoration(
        border: _border,
        filled: true,
        // TODO use theme
        fillColor: _fillColor,
        labelText: _labelText,
        errorText: _errorText,
        errorStyle: const TextStyle(
          color: ColorConstants.RED,
        ),
      ),
    );
  }
}
