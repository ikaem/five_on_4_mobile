import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
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
        ),
      ),
      TabTogglerOptionValue(
        title: "Players",
        child: Container(),
      ),
    ];
  }
}
