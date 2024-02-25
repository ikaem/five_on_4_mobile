import 'dart:async';

import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/inputs_validation_mixin.dart';

mixin StreamInputsValidationMixin on InputsValidationMixin {
  late StreamTransformer<String, String> genericStringValidationTransformer =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      final InputError? error = validateStringInput(data);

      if (error != null) {
        sink.addError(error);
        return;
      }

      sink.add(data);
    },
    handleError: (error, stackTrace, sink) {
      sink.addError(InputError.invalid);
    },
  );
}
