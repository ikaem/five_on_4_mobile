// TODO move this elsewhere - to a separate file
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

// TODO this is same as search matches inputs - maybe it could be reused eventually
class SearchPlayersInput extends StatelessWidget {
  const SearchPlayersInput({
    super.key,
    // TODO one day, this should be possible to use for search by anything: location, description, organizer...
    required this.playerNameTermInputStream,
    required this.playerNameTermTextFieldController,
    required this.onPlayerNameTermInputChanged,
  });

  final Stream<String> playerNameTermInputStream;
  final TextEditingController playerNameTermTextFieldController;
  final ValueSetter<String> onPlayerNameTermInputChanged;

  // TODO in future, ideally one input field would be used to search by all match characteristics:

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamedTextField(
          stream: playerNameTermInputStream,
          textController: playerNameTermTextFieldController,
          onChanged: onPlayerNameTermInputChanged,
          label: "NAME",
          fillColor: ColorConstants.GREY_LIGHT,
        ),
        // TODO button for filtering or filtering options will be here
      ],
    );
  }
}
