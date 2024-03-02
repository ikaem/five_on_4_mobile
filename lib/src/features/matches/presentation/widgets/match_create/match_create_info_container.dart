import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info.dart';
import 'package:flutter/material.dart';

class MatchCreateInfoContainer extends StatefulWidget {
  const MatchCreateInfoContainer({
    super.key,
    required this.nameStream,
    required this.onNameChanged,
    required this.dateTimeStream,
    required this.onDateTimeChanged,
    required this.descriptionStream,
    required this.onDescriptionChanged,
    required this.locationStream,
    required this.onLocationChanged,
    required this.isLoading,
    required this.isError,
    required this.onRetry,
  });

  final Stream<String> nameStream;
  final ValueSetter<String> onNameChanged;
  final Stream<DateTime> dateTimeStream;
  final ValueSetter<DateTime?> onDateTimeChanged;
  final Stream<String> descriptionStream;
  final ValueSetter<String> onDescriptionChanged;
  final Stream<String> locationStream;
  final ValueSetter<String> onLocationChanged;

  final bool isLoading;
  final bool isError;
  final Future<void> Function() onRetry;

  @override
  State<MatchCreateInfoContainer> createState() =>
      _MatchCreateInfoContainerState();
}

class _MatchCreateInfoContainerState extends State<MatchCreateInfoContainer> {
  final _nameController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO not sure if this will react becasue the widget values changes, not the state
    // maybe will need to use didUpdateWidget to set local value
    if (widget.isError) {
      return ErrorStatus(
        message: "There was an issue creating match",
        onRetry: widget.onRetry,
      );
    }

    if (widget.isLoading) {
      return const LoadingStatus(
        message: "Creating match...",
      );
    }

    return MatchCreateInfo(
      nameStream: widget.nameStream,
      nameController: _nameController,
      onNameChanged: widget.onNameChanged,
      dateTimeStream: widget.dateTimeStream,
      dateTimeController: _dateTimeController,
      onDateTimeChanged: widget.onDateTimeChanged,
      descriptionStream: widget.descriptionStream,
      descriptionController: _descriptionController,
      onDescriptionChanged: widget.onDescriptionChanged,
      locationStream: widget.locationStream,
      locationController: _locationController,
      onLocationChanged: widget.onLocationChanged,
    );
  }

  void _onDispose() {
    _nameController.dispose();
    _dateTimeController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
  }
}
