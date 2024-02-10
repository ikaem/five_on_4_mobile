import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_events_container.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/home/home_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/matches_controller_state_value.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO views are legitimate parts of screens
// screen views should retrieve state

// TODO move to domain value and explain why it's here and what it is used for - or maybe it is good to be used here because this is the only place to be used
class MatchesUIStateValue {
  const MatchesUIStateValue({
    required this.isLoading,
    required this.isSyncing,
    required this.todayMatches,
    required this.upcomingMatches,
    required this.pastMatches,
  });

  final bool isLoading;
  final bool isSyncing;
  final List<MatchModel> todayMatches;
  final List<MatchModel> upcomingMatches;
  final List<MatchModel> pastMatches;
}

class HomeScreenView extends ConsumerWidget {
  const HomeScreenView({
    super.key,
    // required this.matchesToday,
    // required this.matchesFollowing,
  });

  // final MatchesUIStateValue matchesToday;
  // final MatchesUIStateValue matchesFollowing;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final matchesControllerState = ref.watch(getMyMatchesControllerProvider);
    final matchesUIState = _getMatchesUIState(matchesControllerState);
    final togglerOptions = _getTogglerOptions(
      matchesUIState: matchesUIState,
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

  // List<TabTogglerOptionValue> get _togglerOptions => [
  //       TabTogglerOptionValue(
  //         title: "Today",
  //         child: HomeEventsContainer(
  //           isToday: true,
  //           isLoading: matchesToday.isLoading,
  //           isSyncing: matchesToday.isSyncing,
  //           matches: matchesToday.matches,
  //         ),
  //       ),
  //       TabTogglerOptionValue(
  //         title: "Following",
  //         child: HomeEventsContainer(
  //           isToday: false,
  //           isLoading: matchesFollowing.isLoading,
  //           isSyncing: matchesFollowing.isSyncing,
  //           matches: matchesFollowing.matches,
  //         ),
  //       ),
  //     ];

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchesUIStateValue matchesUIState,
  }) {
    return [
      TabTogglerOptionValue(
        title: "Today",
        child: HomeEventsContainer(
          isToday: true,
          isLoading: matchesUIState.isLoading,
          isSyncing: matchesUIState.isSyncing,
          matches: matchesUIState.todayMatches,
        ),
      ),
      TabTogglerOptionValue(
        title: "Following",
        child: HomeEventsContainer(
          isToday: false,
          isLoading: matchesUIState.isLoading,
          isSyncing: matchesUIState.isSyncing,
          matches: matchesUIState.upcomingMatches,
        ),
      ),
    ];
  }

  // TODO this is a convertor of some kind - maybe move it to converter eventually
  MatchesUIStateValue _getMatchesUIState(
    AsyncValue<MatchesControllerStateValue> matchesControllerState,
  ) {
    final isLoading = matchesControllerState.when(
      data: (data) => false,
      error: (error, stackTrace) => false,
      loading: () => true,
    );
    final isSyncing = matchesControllerState.when(
      data: (data) => !data.isRemoteFetchDone,
      error: (error, stackTrace) => false,
      loading: () => false,
    );
    final todayMatches = matchesControllerState.when<List<MatchModel>>(
      data: (data) => data.todayMatches,
      error: (error, stackTrace) => [],
      loading: () => [],
    );
    final upcomingMatches = matchesControllerState.when<List<MatchModel>>(
      data: (data) => data.upcomingMatches,
      error: (error, stackTrace) => [],
      loading: () => [],
    );
    final pastMatches = matchesControllerState.when<List<MatchModel>>(
      data: (data) => data.pastMatches,
      error: (error, stackTrace) => [],
      loading: () => [],
    );

    return MatchesUIStateValue(
      isLoading: isLoading,
      isSyncing: isSyncing,
      todayMatches: todayMatches,
      upcomingMatches: upcomingMatches,
      pastMatches: pastMatches,
    );
  }
}
