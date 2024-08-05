import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/streamed_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players/provider/search_players_controller.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/screens/search_screen_view.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/players/search_players_inputs.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/players/search_players_results_presenter.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO not sure where to move this - it might even stay here since it belongs to this widget

class SearchPlayersUIState extends Equatable {
  const SearchPlayersUIState({
    required this.isLoading,
    required this.isError,
    required this.players,
  });

  final bool isLoading;
  final bool isError;
  final List<PlayerModel> players;

  @override
  List<Object> get props => [isLoading, isError, players];
}

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
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<SearchPlayersControllerState>
        searchPlayersControllerState =
        ref.watch(searchPlayersControllerProvider);

    final searchPlaersUIState =
        _getSearchPlayersUIState(searchPlayersControllerState);

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
          onPressed: () => ref
              .read(searchPlayersControllerProvider.notifier)
              .onSearchPlayers(
                // TODO temp here
                // TODO later, we should possibly take value from the inputs controller, not from the text field controller
                // TODO, but also maybe from the text controller
                nameTerm: "Kar",
              ),
          label: "Search",
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        Expanded(
          child: SearchPlayersResultsPresenter(
            isLoading: searchPlaersUIState.isLoading,
            isError: searchPlaersUIState.isError,
            players: searchPlaersUIState.players,
          ),
        ),
      ],
    );
  }

  void _onDispose() {
    playerNameTermTextFieldController.dispose();
  }

  SearchPlayersUIState _getSearchPlayersUIState(
      AsyncValue<SearchPlayersControllerState> searchPlayersControllerState) {
    final bool isLoading = searchPlayersControllerState.maybeWhen(
        orElse: () => false, loading: () => true);

    final bool isError = searchPlayersControllerState.maybeWhen(
        orElse: () => false, error: (e, s) => true);

    final List<PlayerModel> foundPlayers =
        searchPlayersControllerState.maybeWhen(
            orElse: () => _tempPlayers, data: (data) => data.foundPlayers);

    final SearchPlayersUIState state = SearchPlayersUIState(
      isLoading: isLoading,
      isError: isError,
      players: foundPlayers,
    );

    return state;
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
