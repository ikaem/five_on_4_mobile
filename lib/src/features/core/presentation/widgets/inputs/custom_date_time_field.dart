import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDateTimeField extends StatelessWidget {
  CustomDateTimeField({
    super.key,
    required String labelText,
    required Color fillColor,
    required DateTimeInputOnTapSetter onTapSetter,
    String? errorText,
    InputBorder? border,
  })  : _labelText = labelText,
        _fillColor = fillColor,
        _border = border ?? InsideLabeledOutlineInputBorder.allRounded(),
        _onTapSetter = onTapSetter,
        _errorText = errorText;

  final String _labelText;
  final Color _fillColor;
  final InputBorder _border;
  final String? _errorText;
  final DateTimeInputOnTapSetter _onTapSetter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _onTapSetter.textController,
      readOnly: true,
      decoration: InputDecoration(
        border: _border,
        filled: true,
        fillColor: _fillColor,
        labelText: _labelText,
        errorText: _errorText,
        errorStyle: const TextStyle(
          color: ColorConstants.RED,
        ),
      ),
      onTap: () => _onTapSetter.onTap(context),
    );
  }
}
