import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_match/provider/get_match_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO move view and view test to screen folder

class MatchUIState {
  const MatchUIState({
    required this.isLoading,
    required this.isSyncing,
    required this.isError,
    required this.match,
  });

  final bool isLoading;
  final bool isSyncing;
  final bool isError;
  final MatchModel? match;
}

class MatchScreenView extends ConsumerStatefulWidget {
  const MatchScreenView({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchViewState();
}

class _MatchViewState extends ConsumerState<MatchScreenView> {
  late final getMatchControllerProviderInstance = getMatchControllerProvider(
    matchId: widget.matchId,
  );
  late final onMatchReload =
      ref.read(getMatchControllerProviderInstance.notifier).onMatchReload;

  @override
  Widget build(
    BuildContext context,
  ) {
    final matchControllerState = ref.watch(getMatchControllerProviderInstance);
    final matchUIState = _getMatchUIState(matchControllerState);
    final togglerOptions = _getTogglerOptions(
      matchUIState: matchUIState,
      onRetry: onMatchReload,
    );

    return TabToggler(
      options: togglerOptions,
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchUIState matchUIState,
    required Future<void> Function() onRetry,
  }) {
    final match = matchUIState.match;
    final participants = match?.arrivingPlayers ?? [];
    final isLoading = matchUIState.isLoading;
    final isError = matchUIState.isError;
    final isSyncing = matchUIState.isSyncing;

    return [
      TabTogglerOptionValue(
        title: "Info",
        child: MatchInfoContainer(
          match: match,
          isError: isError,
          isLoading: isLoading,
          isSyncing: isSyncing,
          onRetry: onRetry,
        ),
      ),
      TabTogglerOptionValue(
        title: "Participants",
        child: MatchParticipantsContainer(
          participants: participants,
          isError: isError,
          isLoading: isLoading,
          isSyncing: isSyncing,
        ),
      ),
    ];
  }

  MatchUIState _getMatchUIState(
    AsyncValue<GetMatchControllerState> matchControllerState,
  ) {
    final isLoading = matchControllerState.maybeWhen(
      orElse: () => false,
      loading: () => true,
    );

    final isSyncing = matchControllerState.maybeWhen(
      orElse: () => false,
      data: (data) => !data.isRemoteFetchDone,
    );

    final isError = matchControllerState.maybeWhen(
      orElse: () => false,
      error: (error, stackTrace) => true,
    );

    final match = matchControllerState.maybeWhen(
      orElse: () => null,
      data: (state) => state.match,
    );

    return MatchUIState(
      isLoading: isLoading,
      isSyncing: isSyncing,
      isError: isError,
      match: match,
    );
  }
}

// class MatchView extends ConsumerWidget {
//   const MatchView({
//     super.key,
//     // required this.match,
//     required this.matchId,
//   });

//   // final MatchModel match;ž
//   final int matchId;

//   @override
//   Widget build(
//     BuildContext context,
//     WidgetRef ref,
//   ) {
//     return TabToggler(
//       options: _togglerOptions,
//     );
//   }

//   List<TabTogglerOptionValue> get _togglerOptions => [
//         TabTogglerOptionValue(
//           title: "Info",
//           child: MatchInfoContainer(
//             match: match,
//           ),
//         ),
//         TabTogglerOptionValue(
//           title: "Participants",
//           child: MatchParticipantsContainer(
//             participants: match.arrivingPlayers,
//           ),
//         ),
//       ];
// }
