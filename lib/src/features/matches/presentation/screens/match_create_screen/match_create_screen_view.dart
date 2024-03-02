import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match/provider/create_match_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match_inputs/create_match_inputs_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MatchCreateUIState {
  const MatchCreateUIState({
    required this.isLoading,
    required this.isError,
    required this.matchId,
  });

  final bool isLoading;
  final bool isError;
  final int? matchId;
}

class MatchCreateScreenView extends ConsumerStatefulWidget {
  const MatchCreateScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MatchCreateScreenViewState();
}

class _MatchCreateScreenViewState extends ConsumerState<MatchCreateScreenView> {
// TODO test

  final matchCreateInputsController = CreateMatchInputsController();

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchCreateControllerState = ref.watch(createMatchControllerProvider);
    final matchCreateUIState =
        _getMatchCreateUIState(matchCreateControllerState);
    final togglerOptions = _getTogglerOptions(
      matchCreateUIState: matchCreateUIState,
      // TODO this needs to be tested
      onRetry: () async {
        context.go(RoutePathsConstants.ROOT.value);
      },
      // input controller values
      nameStream: matchCreateInputsController.validatedNameStream,
      onNameChanged: matchCreateInputsController.onNameChanged,
      dateTimeStream: matchCreateInputsController.validatedDateTimeStream,
      onDateTimeChanged: matchCreateInputsController.onDateTimeChanged,
      descriptionStream: matchCreateInputsController.validatedDescriptionStream,
      onDescriptionChanged: matchCreateInputsController.onDescriptionChanged,
    );

    return Scaffold(
      appBar: AppBar(),
      body: TabToggler(
        options: togglerOptions,
      ),
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchCreateUIState matchCreateUIState,
    required Future<void> Function() onRetry,
    // input controller values
    required Stream<String> nameStream,
    required ValueSetter<String> onNameChanged,
    required Stream<DateTime> dateTimeStream,
    required ValueSetter<DateTime?> onDateTimeChanged,
    required Stream<String> descriptionStream,
    required ValueSetter<String> onDescriptionChanged,
  }) {
    return [
      // TODO stopped here
      TabTogglerOptionValue(
        title: "Info",
        child: MatchCreateInfoContainer(
          nameStream: nameStream,
          onNameChanged: onNameChanged,
          dateTimeStream: dateTimeStream,
          onDateTimeChanged: onDateTimeChanged,
          descriptionStream: descriptionStream,
          onDescriptionChanged: onDescriptionChanged,
          isLoading: matchCreateUIState.isLoading,
          isError: matchCreateUIState.isError,
          onRetry: onRetry,
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

  Future<void> _onDispose() async {
    await matchCreateInputsController.dispose();
  }
}

MatchCreateUIState _getMatchCreateUIState(
  AsyncValue<CreateMatchControllerState?> createMatchControllerState,
) {
  final isLoading = createMatchControllerState.maybeWhen<bool>(
    orElse: () => false,
    loading: () => true,
  );

  final isError = createMatchControllerState.maybeWhen<bool>(
    orElse: () => false,
    error: (error, _) => true,
  );

  final matchId = createMatchControllerState.maybeWhen<int?>(
    orElse: () => null,
    data: (state) => state?.matchId,
  );

  return MatchCreateUIState(
    isLoading: isLoading,
    isError: isError,
    matchId: matchId,
  );
}
