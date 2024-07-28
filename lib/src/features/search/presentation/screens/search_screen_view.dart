import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/sarch_matches_inputs/provider/search_matches_inputs_controller_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/sarch_matches_inputs/search_matches_inputs_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/search_matches/provider/search_matches_controller.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/search_matches_container.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO maybe this should live elsewhere
class SearchMatchesUIState extends Equatable {
  const SearchMatchesUIState({
    required this.isLoading,
    required this.isError,
    required this.foundMatches,
  });

  final bool isLoading;
  final bool isError;
  final List<MatchModel> foundMatches;

  @override
  List<Object> get props => [isLoading, isError, foundMatches];
}

// class SearchScreenView extends ConsumerStatefulWidget {
class SearchScreenView extends ConsumerStatefulWidget {
  const SearchScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchScreenViewState();
}

class _SearchScreenViewState extends ConsumerState<SearchScreenView> {
// TODO this should probably be instantiated closer to the inputs widget of search matches - but let it me here for now

  late final SearchMatchesInputsController searchMatchesInputsController =
      ref.read(searchMatchesInputsControllerProvider);

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
    // WidgetRef ref,
  ) {
    // TODO maybe this should eventually live in the tab for matches search, not in the parent - we will see - leave it here for now
    final searchMatchesControllerState =
        ref.watch(searchMatchesControllerProvider);
    final searchMatchesUIState =
        _getSearchMatchesUIState(searchMatchesControllerState);
    final togglerOptions = _getTogglerOptions(
      matchTitleStream: searchMatchesInputsController.validatedMatchTitleStream,
      onMatchTitleChanged: searchMatchesInputsController.onMatchTitleChanged,
      areInputsValidStream: searchMatchesInputsController.areInputsValidStream,
      searchMatchesUIState: searchMatchesUIState,
      onLoadMore: () async {},
      onSearchButtonPressed: (value) async {
        // TODO probably no need to await it here
        // could also use cutoff
        await ref
            .read(searchMatchesControllerProvider.notifier)
            .onSearchMatches(matchTitle: value);
      },
    );

    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,
      appBar: AppBar(
        // TODO to remove back button
        automaticallyImplyLeading: false,
        title: const Text("Search"),
        centerTitle: true,
        backgroundColor: ColorConstants.BLUE_LIGHT,
      ),
      // body: const Column(),
      body: TabToggler(
        options: togglerOptions,
        backgroundColor: ColorConstants.WHITE,
      ),
    );
  }

  Future<void> _onDispose() async {
    await searchMatchesInputsController.dispose();
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    // will need state of found matches
    // TODO might need some load more on scroll or something?
    required SearchMatchesUIState searchMatchesUIState,
    required Future<void> Function() onLoadMore,
    required Future<void> Function(String) onSearchButtonPressed,
    required Stream<String> matchTitleStream,
    required ValueSetter<String> onMatchTitleChanged,
    // all inputs validation stream
    required Stream<bool> areInputsValidStream,
  }) {
    return [
      TabTogglerOptionValue(
        title: "MATCHES",
        // child: Container(),
        child: SearchMatchesContainer(
          isLoading: searchMatchesUIState.isLoading,
          isError: searchMatchesUIState.isError,
          onMatchTitleInputChanged: onMatchTitleChanged,
          matchTitleInputStream: matchTitleStream,
          matches: searchMatchesUIState.foundMatches,
          onSearchButtonPressed: onSearchButtonPressed,
          areInputsValidStream: areInputsValidStream,
        ),
      ),
      TabTogglerOptionValue(
        title: "PLAYERS",
        child: Container(),
      ),
    ];
  }

  SearchMatchesUIState _getSearchMatchesUIState(
    AsyncValue<SearchMatchesControllerState> searchMatchesControllerState,
  ) {
    final isLoading = searchMatchesControllerState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final isError = searchMatchesControllerState.maybeWhen(
      error: (e, s) => true,
      orElse: () => false,
    );

    final foundMatches =
        searchMatchesControllerState.maybeWhen<List<MatchModel>>(
      data: (data) => data.foundMatches,
      orElse: () => [],
    );

    final state = SearchMatchesUIState(
      isLoading: isLoading,
      isError: isError,
      foundMatches: foundMatches,
    );
    return state;
  }
}

// TODO temp for now - matches will come from controller state later
final List<MatchModel> _tempMatches = List.generate(
    10,
    (i) => MatchModel(
          id: 1,
          dateAndTime: DateTime.now(),
          location: "Location",
          description: "Description",
          title: "Title",
        ));
