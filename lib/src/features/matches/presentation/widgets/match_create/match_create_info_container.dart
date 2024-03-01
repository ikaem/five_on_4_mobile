import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info.dart';
import 'package:flutter/material.dart';

class MatchCreateInfoContainer extends StatefulWidget {
  const MatchCreateInfoContainer({super.key});

  @override
  State<MatchCreateInfoContainer> createState() =>
      _MatchCreateInfoContainerState();
}

class _MatchCreateInfoContainerState extends State<MatchCreateInfoContainer> {
// TODO test only
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MatchCreateInfo(
      // TODO temp
      nameStream: Stream.fromIterable([""]),
      nameController: _nameController,
      onNameChanged: (value) {
        // TODO temp
      },
      // TODO temp only
      dateTimeStream: const Stream<DateTime>.empty(),
      dateTimeController: TextEditingController(),
      onDateTimeChanged: (value) {
        // TODO temp
      },
    );
  }

  void _onDispose() {
    _nameController.dispose();
  }
}
