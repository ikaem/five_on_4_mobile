// TODO move this elsewhere - to a separate file
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:flutter/material.dart';

class SearchMatchesInputs extends StatelessWidget {
  const SearchMatchesInputs({
    super.key,
    required this.searchInputStream,
    required this.searchInputController,
    required this.onSearchInputChanged,
  });

  final Stream<String> searchInputStream;
  final TextEditingController searchInputController;
  final ValueSetter<String> onSearchInputChanged;

  // TODO in future, ideally one input field would be used to search by all match characteristics:
  // - name
  // - location
  // - description
  // - organizer

  // by date and time - we would have a filter for that
  // - date
  // - time

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamedTextField(
          stream: searchInputStream,
          textController: searchInputController,
          onChanged: onSearchInputChanged,
          label: "Search",
        ),
        // TODO button for filtering or filtering options will be here
      ],
    );
  }
}
