import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/sign_out/sign_out_controller.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO let this sit here for a bit
//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       serverClientId: serverId,
//       // TODO no need for client id to get id token it seems
//       // // TODO for ios this is maybe not needed
//       // clientId:
//       //     "164480400700-glgi0u7co675c5ubj8qdcbb834rqjqvd.apps.googleusercontent.com",
//       scopes: <String>[
//         // 'email',
//         // "profile",
//         // "openid",
//       ],
//     );

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
    // TODO not sure if this is ok to be here?
    final matchesController =
        ref.read(getMyMatchesOverviewControllerProvider.notifier);

    final matchesControllerState =
        ref.watch(getMyMatchesOverviewControllerProvider);
    final matchesUIState = _getMatchesUIState(matchesControllerState);
    final togglerOptions = _getTogglerOptions(
      matchesUIState: matchesUIState,
      // onRetry: matchesController.onLoadMatchesOverview,
      // TODO revert this
      onRetry: ({required MatchTimeType matchesType}) async {},
    );

    return Scaffold(
      body: Column(
        children: [
          HomeGreeting(
            nickName: "nickName",
            teamName: "teamName",
            avatarUrl: Uri.parse(
                "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () async =>
                await ref.read(signOutControllerProvider.notifier).onSignOut(),
            child: const Text("Logout"),
          ),
          Expanded(
            child: TabToggler(
              options: togglerOptions,
            ),
          ),
        ],
      ),
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchesUIState matchesUIState,
    required Future<void> Function({
      required MatchTimeType matchesType,
    }) onRetry,
  }) {
    onRetryToday() => onRetry(
          matchesType: MatchTimeType.today,
        );

    onRetryUpcoming() => onRetry(
          matchesType: MatchTimeType.upcoming,
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
    AsyncValue<PlayerMatchesOverviewControllerState> matchesControllerState,
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
