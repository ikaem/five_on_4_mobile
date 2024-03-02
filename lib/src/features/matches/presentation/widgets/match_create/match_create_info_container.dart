import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info.dart';
import 'package:flutter/material.dart';

class MatchCreateInfoContainer extends StatefulWidget {
  const MatchCreateInfoContainer({
    super.key,
    required Stream<String> nameStream,
    required ValueSetter<String> onNameChanged,
    required Stream<DateTime> dateTimeStream,
    required ValueSetter<DateTime?> onDateTimeChanged,
    required Stream<String> descriptionStream,
    required ValueSetter<String> onDescriptionChanged,
    required bool isLoading,
    required bool isError,
    required Future<void> Function() onRetry,
  })  : _nameStream = nameStream,
        _onNameChanged = onNameChanged,
        _dateTimeStream = dateTimeStream,
        _onDateTimeChanged = onDateTimeChanged,
        _descriptionStream = descriptionStream,
        _onDescriptionChanged = onDescriptionChanged,
        _isLoading = isLoading,
        _isError = isError,
        _onRetry = onRetry;

// TODO remove private variables here - there is no need for it in widgets
  final Stream<String> _nameStream;
  final ValueSetter<String> _onNameChanged;
  final Stream<DateTime> _dateTimeStream;
  final ValueSetter<DateTime?> _onDateTimeChanged;
  final Stream<String> _descriptionStream;
  final ValueSetter<String> _onDescriptionChanged;

  final bool _isLoading;
  final bool _isError;
  final Future<void> Function() _onRetry;

  @override
  State<MatchCreateInfoContainer> createState() =>
      _MatchCreateInfoContainerState();
}

class _MatchCreateInfoContainerState extends State<MatchCreateInfoContainer> {
  final _nameController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO not sure if this will react becasue the widget values changes, not the state
    // maybe will need to use didUpdateWidget to set local value
    if (widget._isError) {
      return ErrorStatus(
        message: "There was an issue creating match",
        onRetry: widget._onRetry,
      );
    }

    if (widget._isLoading) {
      return const LoadingStatus(
        message: "Creating match...",
      );
    }

    return MatchCreateInfo(
      nameStream: widget._nameStream,
      nameController: _nameController,
      onNameChanged: widget._onNameChanged,
      dateTimeStream: widget._dateTimeStream,
      dateTimeController: _dateTimeController,
      onDateTimeChanged: widget._onDateTimeChanged,
      descriptionStream: widget._descriptionStream,
      descriptionController: _descriptionController,
      onDescriptionChanged: widget._onDescriptionChanged,
    );
  }

  void _onDispose() {
    _nameController.dispose();
    _dateTimeController.dispose();
    _descriptionController.dispose();
  }
}
