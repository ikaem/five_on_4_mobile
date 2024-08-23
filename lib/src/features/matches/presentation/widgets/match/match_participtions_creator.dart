// TODO THIS IS virtually same as in match creatze participations invire
// TODO it should be reused in both places, so create just one
// TODO name should also be changed - this does not really invite
// instead - this
// searches for players only
// and then we would pass callback for on tap player, or something - we can see in future

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/streamed_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/custom_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players/provider/search_players_controller.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players_input/provider/search_players_inputs_controller_provider.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players_input/search_players_input_controller.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO this should probably be using that search players container, because it is solved there, the stuff
// just that that widget shuould  accept some callback for on tap player and so on
// or list of widgets for actions or something

// TODO not sure if this should be different that seach players state - it is practically same, but used in same place
// TODO lets try to unify them later
class SearchPlayersForMatchParticipationUIState extends Equatable {
  const SearchPlayersForMatchParticipationUIState({
    required this.isError,
    required this.isLoading,
    required this.players,
  });

  final bool isLoading;
  final bool isError;
  final List<PlayerModel> players;

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isError, players];
}

// TODO create a better name for this
class MatchParticipationsCreator extends ConsumerStatefulWidget {
  const MatchParticipationsCreator({
    super.key,
    required this.matchId,
    // required this.players,
  });

  final int matchId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MatchParticipationsCreatorState();
}

class _MatchParticipationsCreatorState
    extends ConsumerState<MatchParticipationsCreator> {
  final TextEditingController playerNameTermTextFieldController =
      TextEditingController();

  late final SearchPlayersInputsController searchPlayersInputsController =
      ref.read(searchPlayersInputsControllerProvider);

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  // final List<PlayerModel> players;
  @override
  Widget build(BuildContext context) {
    // TODO this should get provider for searching players
    // TODO make sure that this is not the same instance as in search players - maybe we should adjust it so it does not persist

    final AsyncValue<SearchPlayersControllerState>
        searchPlayersControllerState =
        ref.watch(searchPlayersControllerProvider);

    final SearchPlayersForMatchParticipationUIState
        searchPlayersForMatchParticipationUIState =
        _getSearchPlayersForMatchParticipationUIState(
            searchPlayersControllerState);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamedTextField(
          stream: searchPlayersInputsController.validatedNameTermStream,
          textController: playerNameTermTextFieldController,
          onChanged: (value) {
            searchPlayersInputsController.onNameTermChanged(value);
          },
          label: "PLAYER NAME / NICKNAME",
          fillColor: ColorConstants.GREY_LIGHT,
        ),
        const SizedBox(height: SpacingConstants.S),
        StreamedElevatedButton(
          isEnabledStream: searchPlayersInputsController.areInputsValidStream,
          onPressed: () => ref
              .read(searchPlayersControllerProvider.notifier)
              .onSearchPlayers(
                // TODO temp here
                // TODO later, we should possibly take value from the inputs controller, not from the text field controller
                // TODO, but also maybe from the text controller
                // nameTerm: "Kar",
                // args: const SearchPlayersInputArgsValue(nameTerm: "Kar"),
                args: searchPlayersInputsController
                    .validatedSearchPlayersInputArgsValue,
              ),
          label: "Search",
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        const Text(
          "FOUND PLAYERS",
          style: TextStyle(
            color: ColorConstants.BLUE_DARK,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: SpacingConstants.M),
        // Expanded(
        Flexible(
          flex: 1,
          child: _MatchParticipationsCreatorSearchedPlayersResultsPresenter(
              isLoading: searchPlayersForMatchParticipationUIState.isLoading,
              isError: searchPlayersForMatchParticipationUIState.isError,
              players: searchPlayersForMatchParticipationUIState.players,
              onPlayerTap: (player) {
                // TODO this should add player to match participations
              }
              // TODO this should add player to match participations
              ),
          ///////////////
          // fit: FlexFit.loose,
          // child: _MatchParticipationCreatorPlayersList(
          //   onPlayerTap: (player) {},
          //   foundPlayers: const [],
          //   // foundPlayers: foundPlayers,
          //   // onInvitationAction: onInvitationAction,
          // ),
        ),
      ],
    );
  }

  Future<void> _onDispose() async {
    playerNameTermTextFieldController.dispose();
    await searchPlayersInputsController.dispose();
  }

  SearchPlayersForMatchParticipationUIState
      _getSearchPlayersForMatchParticipationUIState(
          AsyncValue<SearchPlayersControllerState>
              searchPlayersControllerState) {
    final bool isLoading = searchPlayersControllerState.maybeWhen(
        orElse: () => false, loading: () => true);

    final bool isError = searchPlayersControllerState.maybeWhen(
        orElse: () => false, error: (e, s) => true);

    final List<PlayerModel> foundPlayers =
        searchPlayersControllerState.maybeWhen(
      orElse: () => [],
      data: (data) => data.foundPlayers,
    );

    final SearchPlayersForMatchParticipationUIState state =
        SearchPlayersForMatchParticipationUIState(
      isLoading: isLoading,
      isError: isError,
      players: foundPlayers,
    );

    return state;
  }
}

// TODO SOMETHING like this already exists in search players - reuse that
// TODO something not quite like this in UI, but in functionality existts in match create participations creator - reuse that or abstract this to reuse everywhere
class _MatchParticipationsCreatorSearchedPlayersResultsPresenter
    extends StatelessWidget {
  const _MatchParticipationsCreatorSearchedPlayersResultsPresenter({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.players,
    required this.onPlayerTap,
  });

  final bool isLoading;
  final bool isError;
  final List<PlayerModel> players;
  final void Function(PlayerModel player) onPlayerTap;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const ErrorStatus(
        message: "There was an issue searching players",
        onRetry: null,
        // onRetry: () async {
        //   // TODO for now do noting, dont offer it
        // },
      );
    }
    if (isLoading) {
      return const LoadingStatus(
        message: "Searching players...",
      );
    }

    if (players.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: SpacingConstants.M),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO on search screen, make sure that no matches found is same way not in center, but closer to top
            Text(
              "No players found",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.BLACK,
                fontWeight: FontWeight.bold,
                fontSize: TextSizeConstants.LARGE,
              ),
            ),
          ],
        ),
      );
    }

    return _MatchParticipationCreatorPlayersList(
      onPlayerTap: onPlayerTap,
      foundPlayers: players,
    );
  }
}

class _MatchParticipationCreatorPlayersList extends StatelessWidget {
  const _MatchParticipationCreatorPlayersList({
    super.key,
    required this.onPlayerTap,
    required this.foundPlayers,
  });

  final void Function(PlayerModel player) onPlayerTap;
  final List<PlayerModel> foundPlayers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: SpacingConstants.M),
      itemCount: foundPlayers.length,
      itemBuilder: (context, index) {
        final foundPlayer = foundPlayers[index];

        // return MatchPlayerInvitation(
        //   player: foundPlayer,
        //   isAddedToMatchInvitations: false,
        //   onInvitationAction: onInvitationAction,
        // );

        return MatchPlayerParticipation(
          player: foundPlayer,
          actions: const [],
        );
      },
    );
  }
}

// TODO split all of this into separate widgets
