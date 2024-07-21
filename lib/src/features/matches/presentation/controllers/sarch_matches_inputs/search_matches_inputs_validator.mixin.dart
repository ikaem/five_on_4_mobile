// import 'package:five_on_4_mobile/src/features/matches/domain/values/search_matches_input_args_value.dart';

part of "search_matches_inputs_controller.dart";

mixin SearchMatchesInputsValidatorMixin {
  SearchMatchesInputArgsValue? getValidatedArgsFromInputs({
    // TODO this could maybe be optional? lets wait and see
    required String matchTitle,
  }) {
    if (matchTitle.isEmpty) return null;

    return SearchMatchesInputArgsValue(matchTitle: matchTitle);
  }
}
