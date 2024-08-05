part of "search_players_input_controller.dart";

mixin SearchPlayersInputsValidatorMixin {
  SearchPlayersInputArgsValue? getValidatedArgsFromInputs({
    required String nameTerm,
  }) {
    if (nameTerm.isEmpty) return null;

    return SearchPlayersInputArgsValue(nameTerm: nameTerm);
  }
}
