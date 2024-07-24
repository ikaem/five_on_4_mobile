// TODO move this elsewhere - to a separate file
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SearchMatchesInputs extends StatelessWidget {
  const SearchMatchesInputs({
    super.key,
    // TODO one day, this should be possible to use for search by anything: location, description, organizer...
    required this.matchTitleInputStream,
    required this.matchTitleTextFieldController,
    required this.onMatchTitleInputChanged,
  });

  final Stream<String> matchTitleInputStream;
  final TextEditingController matchTitleTextFieldController;
  final ValueSetter<String> onMatchTitleInputChanged;

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
          stream: matchTitleInputStream,
          textController: matchTitleTextFieldController,
          onChanged: onMatchTitleInputChanged,
          label: "Match title",
          fillColor: ColorConstants.WHITE,
        ),
        // TODO button for filtering or filtering options will be here
      ],
    );
  }
}
