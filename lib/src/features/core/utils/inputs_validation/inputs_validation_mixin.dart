import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';

mixin InputsValidationMixin {
  InputError? validateStringInput(String? value) {
    if (value == null) {
      return InputError.empty;
    }

    if (_isStringEmpty(value)) {
      return InputError.empty;
    }
    return null;
  }

  bool _isStringEmpty(String value) {
    return value.isEmpty;
  }
}
