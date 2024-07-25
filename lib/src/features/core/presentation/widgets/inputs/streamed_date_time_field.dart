import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_date_time_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:five_on_4_mobile/src/style/inputs/inside_labeled_outline_input_border.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class StreamedDateTimeField extends StatelessWidget {
  const StreamedDateTimeField({
    super.key,
    required Stream<DateTime> stream,
    required Color fillColor,
    required String label,
    required DateTimeInputOnTapSetter onTapSetter,
    String? errorText,
    InputBorder? border,
  })  : _stream = stream,
        _fillColor = fillColor,
        _border = border,
        _label = label,
        _onTapSetter = onTapSetter,
        _errorText = errorText;

  final Stream<DateTime> _stream;
  final Color _fillColor;
  final String _label;
  final DateTimeInputOnTapSetter _onTapSetter;
  final InputBorder? _border;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime?>(
      stream: _stream,
      builder: (context, snapshot) {
        final hasError = snapshot.hasError;

        return CustomDateTimeField(
          labelText: _label,
          fillColor: _fillColor,
          border: _border,
          errorText: hasError ? _errorText : null,
          onTapSetter: _onTapSetter,
        );
      },
    );
  }
}
