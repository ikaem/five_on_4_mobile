import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MatchesUIState {
  const MatchesUIState({
    required this.isLoading,
    required this.isSyncing,
    required this.todayMatches,
    required this.upcomingMatches,
    required this.pastMatches,
    required this.isError,
  });

  final bool isLoading;
  final bool isSyncing;
  final bool isError;
  final List<MatchModel> todayMatches;
  final List<MatchModel> upcomingMatches;
  final List<MatchModel> pastMatches;
}

class HomeScreenView extends ConsumerWidget {
  const HomeScreenView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final matchesController = ref.read(getMyMatchesControllerProvider.notifier);

    final matchesControllerState = ref.watch(getMyMatchesControllerProvider);
    final matchesUIState = _getMatchesUIState(matchesControllerState);
    final togglerOptions = _getTogglerOptions(
      matchesUIState: matchesUIState,
      onRetry: matchesController.onLoadMatches,
    );

    return Column(
      children: [
        HomeGreeting(
          nickName: "nickName",
          teamName: "teamName",
          avatarUrl: Uri.parse(
              "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
        ),
        Expanded(
          child: TabToggler(
            options: togglerOptions,
          ),
        ),
      ],
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchesUIState matchesUIState,
    required Future<void> Function({
      required MatchesType matchesType,
    }) onRetry,
  }) {
    onRetryToday() => onRetry(
          matchesType: MatchesType.today,
        );

    onRetryUpcoming() => onRetry(
          matchesType: MatchesType.upcoming,
        );

    return [
      TabTogglerOptionValue(
        title: "Today",
        child: HomeEventsContainer(
          isToday: true,
          isLoading: matchesUIState.isLoading,
          isSyncing: matchesUIState.isSyncing,
          matches: matchesUIState.todayMatches,
          isError: matchesUIState.isError,
          onRetry: onRetryToday,
        ),
      ),
      TabTogglerOptionValue(
        title: "Following",
        child: HomeEventsContainer(
          isToday: false,
          isLoading: matchesUIState.isLoading,
          isSyncing: matchesUIState.isSyncing,
          matches: matchesUIState.upcomingMatches,
          isError: matchesUIState.isError,
          onRetry: onRetryUpcoming,
        ),
      ),
    ];
  }

  // TODO this is a convertor of some kind - maybe move it to converter eventually
  MatchesUIState _getMatchesUIState(
    AsyncValue<MatchesControllerState> matchesControllerState,
  ) {
    final isLoading = matchesControllerState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final isSyncing = matchesControllerState.maybeWhen(
      data: (data) => !data.isRemoteFetchDone,
      orElse: () => false,
    );

    final todayMatches = matchesControllerState.maybeWhen<List<MatchModel>>(
      data: (data) => data.todayMatches,
      orElse: () => [],
    );

    final upcomingMatches = matchesControllerState.maybeWhen<List<MatchModel>>(
      data: (data) => data.upcomingMatches,
      orElse: () => [],
    );

    final pastMatches = matchesControllerState.maybeWhen<List<MatchModel>>(
      data: (data) => data.pastMatches,
      orElse: () => [],
    );

    final isError = matchesControllerState.maybeWhen(
      error: (error, stackTrace) => true,
      orElse: () => false,
    );

    final state = MatchesUIState(
      isLoading: isLoading,
      isSyncing: isSyncing,
      todayMatches: todayMatches,
      upcomingMatches: upcomingMatches,
      pastMatches: pastMatches,
      isError: isError,
    );

    return state;
  }
}
