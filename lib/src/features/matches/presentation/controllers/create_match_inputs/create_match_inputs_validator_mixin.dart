part of "create_match_inputs_controller.dart";

mixin CreateMatchInputsValidationMixin {
  MatchCreateInputArgs? getValidatedArgsFromInputs({
    required String name,
    required String location,
    required String description,
    required DateTime? dateTime,
    required List<int> playersForInvite,
  }) {
    if (name.isEmpty) return null;
    if (location.isEmpty) return null;
    if (dateTime == null) return null;
    if (dateTime.isBefore(DateTime.now())) return null;

    return MatchCreateInputArgs(
      name: name,
      location: location,
      description: description,
      // dateTime: dateTime,
      playersForInvite: playersForInvite,
    );
  }
}
