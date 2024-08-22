import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/stream_inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_input_args_value.dart';
import 'package:rxdart/rxdart.dart';

part "search_players_inputs_validator_mixin.dart";

class SearchPlayersInputsController
    with
        InputsValidationMixin,
        StreamInputsValidationMixin,
        SearchPlayersInputsValidatorMixin {
  final BehaviorSubject<String> _nameTermSubject = BehaviorSubject.seeded("");

  Future<void> dispose() async {
    await _nameTermSubject.close();
  }

  // lastest values

  // validated streams
  Stream<String> get validatedNameTermStream =>
      _nameTermStream.transform(genericStringValidationTransformer);

  // latest values -> used for search button to trigger
  // TODO in theory, this could be null - why not - we are allowed to pass no value
  // TODO do the same with search matches inputs contller
  // TODO maybe this should not be taken directly from unvalidated subject? or maybe it is fine,. because validatedSearchPlayersInputArgsValue will be used for the search button
  // TODO we dont even need this - we have valiudatedSearchPlayersInputArgsValue
  // String? get latestNameTermValue => _nameTermSubject.valueOrNull;

  // combined stream - will include more in future - used for enable or disable search button
  Stream<bool> get areInputsValidStream => Rx.combineLatest([
        _nameTermStream,
      ], (values) {
        final validatedArgs = getValidatedArgsFromInputs(
          nameTerm: values[0] as String,
        );
        return validatedArgs != null;
        // TODO as boradcast stream is a temp fix, until we move the controller into players search contrainer, so it will get disposed together with cotnainer when tab switches
        // TODO dont use broadcast stream for now - there should not be any need for it
      });

  // validated input args
  SearchPlayersInputArgsValue? get validatedSearchPlayersInputArgsValue {
    final validatedArgs = getValidatedArgsFromInputs(
      // TODO not sure if value or null should be used
      nameTerm: _nameTermSubject.valueOrNull ?? "",
    );

    return validatedArgs;
  }

  // change handlers
  void onNameTermChanged(String value) {
    _nameTermSink.add(value);
  }

// streams
  Stream<String?> get _nameTermStream => _nameTermSubject.stream;

// sinks
  Sink<String> get _nameTermSink => _nameTermSubject.sink;
}
