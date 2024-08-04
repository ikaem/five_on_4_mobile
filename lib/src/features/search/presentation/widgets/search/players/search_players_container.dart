import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/streamed_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/players/search_players_inputs.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/players/search_players_results_presenter.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPlayersContainer extends ConsumerStatefulWidget {
  const SearchPlayersContainer({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchPlayersContainerState();
}

class _SearchPlayersContainerState
    extends ConsumerState<SearchPlayersContainer> {
// TODO this will instantiate its own controller - and later matches container should do the same

  final TextEditingController playerNameTermTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchPlayersInput(
          playerNameTermInputStream: Stream.value(""),
          playerNameTermTextFieldController: playerNameTermTextFieldController,
          onPlayerNameTermInputChanged: (value) {},
        ),
        const SizedBox(height: SpacingConstants.S),
        StreamedElevatedButton(
          isEnabledStream: Stream.value(true),
          onPressed: () {},
          label: "Search",
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        Expanded(
          child: SearchPlayersResultsPresenter(
            isLoading: false,
            isError: false,
            players: _tempPlayers,
          ),
        ),
      ],
    );
  }
}

// TODO temp - remove when controller arrives
final _tempPlayers = List.generate(
  10,
  (i) => PlayerModel(
    id: i + 1,
    name: "Player $i",
    avatarUri: Uri.parse("https://via.placeholder.com/150"),
    nickname: "Nickname $i",
  ),
);
