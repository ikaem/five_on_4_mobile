import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
import 'package:flutter/material.dart';

class MatchCreateScreenView extends StatelessWidget {
  const MatchCreateScreenView({
    super.key,
  });

  // TODO this will need all arguments here eventually

  @override
  Widget build(BuildContext context) {
    return TabToggler(
      options: _togglerOptions,
    );
  }

  List<TabTogglerOptionValue> get _togglerOptions => [
        TabTogglerOptionValue(
          title: "Info",
          child: MatchCreateInfoContainer(
            nameStream: const Stream<String>.empty(),
            onNameChanged: (String name) {},
            dateTimeStream: const Stream<DateTime>.empty(),
            onDateTimeChanged: (DateTime? dateTime) {},
            descriptionStream: const Stream<String>.empty(),
            onDescriptionChanged: (String description) {},
            isLoading: false,
            isError: false,
            onRetry: () async {},
          ),
        ),
        const TabTogglerOptionValue(
          title: "Participants",
          child: MatchCreateParticipantsContainer(
            playersToInvite: [],
          ),
        ),
      ];
}
