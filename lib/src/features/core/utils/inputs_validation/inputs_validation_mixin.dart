import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';

mixin InputsValidationMixin {
  InputError? validateStringInput(String value) {
    if (_isStringEmpty(value)) {
      return InputError.empty;
    }
    return null;
  }

  bool _isStringEmpty(String value) {
    return value.isEmpty;
  }

// TODO maybe null not needed - but maybe it is needed
  InputError? validateFutureDateTimeInput(DateTime value) {
    if (value.isBefore(DateTime.now())) {
      return InputError.invalid;
    }
    return null;
  }
}

/* 

  bool inputValuesValidator(List<Object?> values) {
    // TODO this is old
    // final String? name = _nameSubject.valueOrNull;
    // final String? locationName = _locationNameSubject.valueOrNull;
    // final String? locationAddress = _locationAddressSubject.valueOrNull;
    // final String? locationCity = _locationCitySubject.valueOrNull;
    // final String? locationCountry = _locationCountrySubject.valueOrNull;
    // final DateTime? date = _dateSubject.valueOrNull;
    // final TimeOfDay? time = _timeSubject.valueOrNull;

    final String? name = values[0] as String?;
    final String? locationName = values[1] as String?;
    final String? locationAddress = values[2] as String?;
    final String? locationCity = values[3] as String?;
    final String? locationCountry = values[4] as String?;
    final DateTime? date = values[5] as DateTime?;
    final TimeOfDay? time = values[6] as TimeOfDay?;

    final MatchCreateInputsValidationValue validationValue = validateInputs(
      nameValue: name,
      locationNameValue: locationName,
      locationAddressValue: locationAddress,
      locationCityValue: locationCity,
      locationCountryValue: locationCountry,
      dateValue: date,
      timeValue: time,
    );

    return validationValue.areInputsValid;
  }


 */

/* TODO remove this


  Stream<bool> get inputsValidationStream => Rx.combineLatest(
        [
          _nameStream,
          _locationNameStream,
          _locationAddressStream,
          _locationCityStream,
          _locationCountryStream,
          _dateStream,
          _timeStream,
        ],
        inputValuesValidator,
      );

 */