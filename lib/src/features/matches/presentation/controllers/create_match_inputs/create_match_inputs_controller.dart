// TODO this might not need to be provided
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/inputs_validation_mixin.dart';
import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/stream_inputs_validation_mixin.dart';
import 'package:rxdart/rxdart.dart';

class CreateMatchInputsController
    with InputsValidationMixin, StreamInputsValidationMixin {
  // CreateMatchInputsController();

  // TODO dont forget to dispose of these

  // subjects
  final BehaviorSubject<String> _nameSubject = BehaviorSubject();
  final BehaviorSubject<String> _locationSubject = BehaviorSubject();
  final BehaviorSubject<String> _descriptionSubject = BehaviorSubject();
  final BehaviorSubject<DateTime> _dateTimeSubject = BehaviorSubject();
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

  // combined streams
  // validatedCreateMatchArgs
  // isValid -> derive it from the args

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

  void onDateTimeChanged(DateTime value) {
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
  Stream<String> get _nameStream => _nameSubject.distinct();
  Stream<String> get _locationStream => _locationSubject.distinct();
  Stream<String> get _descriptionStream => _descriptionSubject.distinct();
  Stream<DateTime> get _dateTimeStream => _dateTimeSubject.distinct();
  Stream<List<int>> get _playersForInviteStream =>
      _playersForInviteSubject.distinct();

  // sinks
  Sink<String> get _nameSink => _nameSubject.sink;
  Sink<String> get _locationSink => _locationSubject.sink;
  Sink<String> get _descriptionSink => _descriptionSubject.sink;
  Sink<DateTime> get _dateTimeSink => _dateTimeSubject.sink;
  Sink<List<int>> get _playersForInviteSink => _playersForInviteSubject.sink;
}

/* 

  final BehaviorSubject<String> _nameSubject = BehaviorSubject();
  final BehaviorSubject<String> _locationNameSubject = BehaviorSubject();
  final BehaviorSubject<String> _locationAddressSubject = BehaviorSubject();
  final BehaviorSubject<String> _locationCitySubject = BehaviorSubject();
  final BehaviorSubject<String> _locationCountrySubject = BehaviorSubject();
  final BehaviorSubject<DateTime?> _dateSubject = BehaviorSubject();
  final BehaviorSubject<TimeOfDay?> _timeSubject = BehaviorSubject();
  final BehaviorSubject<bool> _joinMatchSubject = BehaviorSubject.seeded(false);
  final BehaviorSubject<List<MatchParticipationValue>>
      _participantInvitationsSubject = BehaviorSubject.seeded([]);

 */
