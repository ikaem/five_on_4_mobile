import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/search_matches_inputs.dart';
import 'package:flutter/material.dart';

class SearchMatchesContainer extends StatefulWidget {
  const SearchMatchesContainer({
    super.key,
    required this.searchInputStream,
    required this.onSearchInputChanged,
  });

  final Stream<String> searchInputStream;

  final ValueSetter<String> onSearchInputChanged;
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
      children: [
        SearchMatchesInputs(
          searchInputStream: widget.searchInputStream,
          searchInputController: _searchInputController,
          onSearchInputChanged: widget.onSearchInputChanged,
        ),
        const Divider(),
        // TODO search results will be displayed here
      ],
    );
  }

  void _onDispose() {
    _searchInputController.dispose();
  }
}
