import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/stream_inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/search_matches_input_args_value.dart';
import 'package:rxdart/rxdart.dart';

part "search_matches_inputs_validator.mixin.dart";

class SearchMatchesInputsController
    with
        InputsValidationMixin,
        StreamInputsValidationMixin,
        SearchMatchesInputsValidatorMixin {
  final BehaviorSubject<String> _matchTitleSubject = BehaviorSubject.seeded("");

  Future<void> dispose() async {
    await Future.wait([
      _matchTitleSubject.close(),
    ]);
  }

  // validated streams
  Stream<String> get validatedMatchTitleStream =>
      _matchTitleStream.transform(genericStringValidationTransformer);

  // combined stream - will include more in future - used for enable or disable search button
  Stream<bool> get areInputsValidStream => Rx.combineLatest([
        _matchTitleStream,
      ], (values) {
        final validatedArgs = getValidatedArgsFromInputs(
          matchTitle: values[0] as String,
        );
        return validatedArgs != null;
      });

  SearchMatchesInputArgsValue? get validatedSearchMatchesInputArgsValue {
    final validatedArgs = getValidatedArgsFromInputs(
      // TODO not sure if value or null should be used
      matchTitle: _matchTitleSubject.valueOrNull ?? "",
    );

    return validatedArgs;
  }

  // @override
  // SearchMatchesInputArgsValue? getValidatedArgsFromInputs({
  //   required String matchTitle,
  // }) {
  //   if (matchTitle.isEmpty) return null;

  //   return SearchMatchesInputArgsValue(matchTitle: matchTitle);
  // }

  // change handlers
  void onMatchTitleChanged(String value) {
    // _matchTitleSubject.add(value);
    _matchTitleSink.add(value);
  }

  // streams
  Stream<String?> get _matchTitleStream => _matchTitleSubject.distinct();

  // sinks
  Sink<String> get _matchTitleSink => _matchTitleSubject;
}
