import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/get_player/provider/get_player_controller.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player/player_info_container.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/widgets/player/player_matches_container.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO not sure where the state should be stored - possibly in the same folder? or here?
class PlayerUIState extends Equatable {
  const PlayerUIState({
    required this.isLoading,
    required this.isError,
    required this.player,
  });

  final bool isLoading;
  final bool isError;
  final PlayerModel? player;

  @override
  List<Object?> get props => [isLoading, isError, player];
}

class PlayerScreenView extends ConsumerStatefulWidget {
  const PlayerScreenView({
    super.key,
    required this.playerId,
  });

  final int playerId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlayerScreenViewState();
  }
}

class _PlayerScreenViewState extends ConsumerState<PlayerScreenView> {
// TODO using stateful widget so it does not get recreated, and so kill controller- but maybe it is fine - we will see

  late final getPlayerControllerProviderInstance =
      getPlayerControllerProvider(playerId: widget.playerId);

  @override
  Widget build(BuildContext context) {
    final getPlayerControllerState =
        ref.watch(getPlayerControllerProviderInstance);
    final playerUIState = _getPlayerUIState(getPlayerControllerState);
    final togglerOptions = _getToggleOptions(playerUIState: playerUIState);

    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,
      appBar: AppBar(
        backgroundColor: ColorConstants.BLUE_LIGHT,
      ),
      body: TabToggler(
        options: togglerOptions,
        backgroundColor: ColorConstants.WHITE,
      ),
    );
  }

  List<TabTogglerOptionValue> _getToggleOptions({
    required PlayerUIState playerUIState,
  }) {
    return [
      TabTogglerOptionValue(
        title: "PLAYER INFO",
        child: PlayerInfoContainer(
          isLoading: playerUIState.isLoading,
          isError: playerUIState.isError,
          player: playerUIState.player,
        ),
      ),
      TabTogglerOptionValue(
        title: "MATCHES",
        // child: Container(),
        child: PlayerMatchesContainer(
          isLoading: playerUIState.isLoading,
          isError: playerUIState.isError,
          matches: _tempPlayerMatches,
        ),
      ),
    ];
  }

  PlayerUIState _getPlayerUIState(
      AsyncValue<GetPlayerControllerState> getPlayerControllerState) {
    final isLoading = getPlayerControllerState.maybeWhen(
      orElse: () => false,
      loading: () => true,
    );

    final isError = getPlayerControllerState.maybeWhen(
      orElse: () => false,
      error: (error, stackTrace) => true,
    );

    final player = getPlayerControllerState.maybeWhen(
      orElse: () => null,
      data: (state) => state.player,
    );

    final uiState = PlayerUIState(
      isLoading: isLoading,
      isError: isError,
      player: player,
    );

    return uiState;
  }
}

// TODO temp until fetch player is implemented
final _tempPlayer = PlayerModel(
  avatarUri:
      Uri.parse("https://images.unsplash.com/photo-1438761681033-6461ffad8d80"),
  name: "John Doe",
  nickname: "John",
  id: 1,
);

// TODO temp until implement player matches
final _tempPlayerMatches = List.generate(
    11,
    (i) => MatchModel(
          id: i + 1,
          title: "Match title $i",
          dateAndTime: DateTime.now(),
          location: "Location $i",
          description: "Description $i",
        ));
