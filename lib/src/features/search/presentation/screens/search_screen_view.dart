import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/search_matches_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreenView extends ConsumerWidget {
  const SearchScreenView({super.key});
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final togglerOptions = _getTogglerOptions(
      onLoadMore: () async {},
    );

    return Scaffold(
      appBar: AppBar(
        // TODO to remove back button
        automaticallyImplyLeading: false,
        title: const Text("Search"),
        centerTitle: true,
      ),
      // body: const Column(),
      body: TabToggler(
        options: togglerOptions,
      ),
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    // will need state of found matches
    // TODO might need some load more on scroll or something?
    required Future<void> Function() onLoadMore,
  }) {
    return [
      TabTogglerOptionValue(
        title: "Matches",
        // child: Container(),
        child: SearchMatchesContainer(
          onSearchInputChanged: (value) {},
          searchInputStream: const Stream.empty(),
          matches: _tempMatches,
        ),
      ),
      TabTogglerOptionValue(
        title: "Players",
        child: Container(),
      ),
    ];
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
