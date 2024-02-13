import 'package:five_on_4_mobile/src/features/core/presentation/screens/home_screen/home_screen_view.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/matches_controller_state_value.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_my_matches/provider/get_my_matches_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO move to domain value and explain why it's here and what it is used for - or maybe it is good to be used here because this is the only place to be used
// class MatchesUIStateValue {
//   const MatchesUIStateValue({
//     required this.isLoading,
//     required this.isSyncing,
//     required this.matches,
//   });

//   final bool isLoading;
//   final bool isSyncing;
//   final List<MatchModel> matches;
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    // WidgetRef ref,
  ) {
    // final matchesTodayState = ref.watch(getMyTodayMatchesControllerProvider);
    // final matchesToday = _getMatchesState(matchesTodayState);

    return const SafeArea(
      child: Scaffold(
        body: HomeScreenView(
            // matchesToday: matchesToday,
            // // TODO temp data
            // matchesFollowing: const MatchesUIStateValue(
            //   isLoading: false,
            //   isSyncing: false,
            //   matches: [],
            // ),
            ),
      ),
    );
  }

  // TODO this logic is moved to view

  // TODO this is a convertor of some kind - maybe move it to converter eventually
  // MatchesUIStateValue _getMatchesState(
  //   AsyncValue<MatchesControllerStateValue> matchesState,
  // ) {
  //   final isLoading = matchesState.when(
  //     data: (data) => false,
  //     error: (error, stackTrace) => false,
  //     loading: () => true,
  //   );
  //   final isSyncing = matchesState.when(
  //     data: (data) => !data.isRemoteFetchDone,
  //     error: (error, stackTrace) => false,
  //     loading: () => false,
  //   );
  //   final matches = matchesState.when<List<MatchModel>>(
  //     data: (data) => data.matches,
  //     error: (error, stackTrace) => [],
  //     loading: () => [],
  //   );

  //   return MatchesUIStateValue(
  //     isLoading: isLoading,
  //     isSyncing: isSyncing,
  //     matches: matches,
  //   );
  // }
}
