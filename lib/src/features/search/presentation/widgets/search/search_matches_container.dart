import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/matches_list.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/search_matches_inputs.dart';
import 'package:flutter/material.dart';

class SearchMatchesContainer extends StatefulWidget {
  const SearchMatchesContainer({
    super.key,
    required this.searchInputStream,
    required this.onSearchInputChanged,
    required this.matches,
    required this.onSearchButtonPressed,
  });

  final Stream<String> searchInputStream;
  final ValueSetter<String> onSearchInputChanged;
  final ValueSetter<String> onSearchButtonPressed;

  final List<MatchModel> matches;

  @override
  State<SearchMatchesContainer> createState() => _SearchMatchesContainerState();
}

class _SearchMatchesContainerState extends State<SearchMatchesContainer> {
  final TextEditingController _searchInputController = TextEditingController();

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchMatchesInputs(
          searchInputStream: widget.searchInputStream,
          searchInputController: _searchInputController,
          onSearchInputChanged: widget.onSearchInputChanged,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // fixedSize:
            fixedSize: Size(MediaQuery.of(context).size.width, 50),
          ),
          onPressed: () => widget.onSearchButtonPressed("Iv"),
          child: const Text("Search"),
        ),
        const Divider(),
        // if we use riverpod state from controller here, fields will be cleared on every rebuild? maybe - we will see
        // TODO search results will be displayed here
        // TODO will have loading and such here
        Expanded(
          child: MatchesList(
            matches: widget.matches,
          ),
        ),
      ],
    );
  }

  void _onDispose() {
    _searchInputController.dispose();
  }
}
