// TODO this might not need to be provided
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/stream_inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
import 'package:rxdart/rxdart.dart';

part "create_match_inputs_validator_mixin.dart";

// TODO this needs testing
// TODO should probably be provided to make sure it is disposed easier
// TODO also, its is probably good to provide it so we can mock it with testing
class CreateMatchInputsController
    with
        InputsValidationMixin,
        StreamInputsValidationMixin,
        CreateMatchInputsValidationMixin {
  // CreateMatchInputsController();

  // TODO dont forget to dispose of these
  Future<void> dispose() async {
    await Future.wait([
      _nameSubject.close(),
      _locationSubject.close(),
      _descriptionSubject.close(),
      _dateTimeSubject.close(),
      _playersForInviteSubject.close(),
    ]);
  }

  final BehaviorSubject<String> _nameSubject = BehaviorSubject.seeded("");
  final BehaviorSubject<String> _locationSubject = BehaviorSubject.seeded("");
  final BehaviorSubject<String> _descriptionSubject =
      BehaviorSubject.seeded("");
  final BehaviorSubject<DateTime?> _dateTimeSubject =
      // BehaviorSubject.seeded(DateTime.now());
      BehaviorSubject();

  // NOTE seeding because we need to have a value to start with
  final BehaviorSubject<List<int>> _playersForInviteSubject =
      BehaviorSubject.seeded([]);

  // validated streams
  Stream<String> get validatedNameStream =>
      _nameStream.transform(genericStringValidationTransformer);
  Stream<String> get validatedLocationStream =>
      _locationStream.transform(genericStringValidationTransformer);
  // TODO no need to validate i think
  Stream<String> get validatedDescriptionStream => _descriptionStream;
  Stream<DateTime> get validatedDateTimeStream =>
      _dateTimeStream.transform(futureDateTimeValidationTransformer);
  Stream<List<int>> get validatedPlayersForInviteStream =>
      _playersForInviteStream;
  Stream<bool> get areInputsValidStream => Rx.combineLatest([
        _nameStream,
        _locationStream,
        _descriptionStream,
        _dateTimeStream,
        _playersForInviteStream,
      ], (values) {
        final validatedArgs = getValidatedArgsFromInputs(
          name: values[0] as String,
          location: values[1] as String,
          description: values[2] as String,
          dateTime: values[3] as DateTime,
          playersForInvite: values[4] as List<int>,
        );

        return validatedArgs == null ? false : true;
      });

  MatchCreateInputArgs? get validatedMatchCreateInputArgs {
    final validatedArgs = getValidatedArgsFromInputs(
      name: _nameSubject.value,
      location: _locationSubject.value,
      description: _descriptionSubject.value,
      dateTime: _dateTimeSubject.value,
      playersForInvite: _playersForInviteSubject.value,
    );

    return validatedArgs;
  }

  // handlers
  void onNameChanged(String value) {
    _nameSink.add(value);
  }

  void onLocationChanged(String value) {
    _locationSink.add(value);
  }

  void onDescriptionChanged(String value) {
    _descriptionSink.add(value);
  }

  void onDateTimeChanged(DateTime? value) {
    _dateTimeSink.add(value);
  }

  void onPlayersForInviteChanged(int value) {
    final List<int> currentPlayersForInvite = [
      ..._playersForInviteSubject.value
    ];
    currentPlayersForInvite.add(value);
    _playersForInviteSink.add(currentPlayersForInvite);
  }

  // streams
  Stream<String?> get _nameStream => _nameSubject.distinct();
  Stream<String?> get _locationStream => _locationSubject.distinct();
  Stream<String> get _descriptionStream => _descriptionSubject.distinct();
  Stream<DateTime?> get _dateTimeStream => _dateTimeSubject.distinct();
  Stream<List<int>> get _playersForInviteStream =>
      _playersForInviteSubject.distinct();

  // sinks
  Sink<String> get _nameSink => _nameSubject.sink;
  Sink<String> get _locationSink => _locationSubject.sink;
  Sink<String> get _descriptionSink => _descriptionSubject.sink;
  Sink<DateTime?> get _dateTimeSink => _dateTimeSubject.sink;
  Sink<List<int>> get _playersForInviteSink => _playersForInviteSubject.sink;
}
