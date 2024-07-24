import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required String labelText,
    required Color fillColor,
    InputBorder? border,
    bool? shouldObscureText,
  })  : _labelText = labelText,
        _fillColor = fillColor,
        _border = border ?? InsideLabeledOutlineInputBorder.allRounded(),
        _shouldObscureText = shouldObscureText ?? false;

  final bool _shouldObscureText;
  final String _labelText;
  final Color _fillColor;
  final InputBorder _border;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _shouldObscureText,
      decoration: InputDecoration(
        border: _border,
        filled: true,
        // TODO use theme
        fillColor: _fillColor,
        labelText: _labelText,
      ),
    );
  }
}
