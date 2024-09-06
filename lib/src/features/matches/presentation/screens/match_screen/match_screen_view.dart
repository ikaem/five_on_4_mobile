import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/get_authenticated_player/provider/get_authenticated_player_controller.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_match/provider/get_match_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/models/player_match_participation/player_match_participation_model.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/join_match/provider/join_match_controller.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/unjoin_match/provider/unjoin_match_controller.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MatchUIState {
  const MatchUIState({
    required this.isLoading,
    required this.isSyncing,
    required this.isError,
    required this.match,
  });

  final bool isLoading;
  final bool isSyncing;
  final bool isError;
  // TODO why is this nullable?
  final MatchModel? match;
}

class MatchScreenView extends ConsumerStatefulWidget {
  const MatchScreenView({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchViewState();
}

class _MatchViewState extends ConsumerState<MatchScreenView> {
  late final getMatchControllerProviderInstance = getMatchControllerProvider(
    matchId: widget.matchId,
  );
  // TODO come back to this - make issue out of this - i guess match data should be updated or something - with players maybe? maybe when i invite new players? or basically any time i navigate to the screen or something?
  // late final onMatchReload =
  //     ref.read(getMatchControllerProviderInstance.notifier).onMatchReload;
  // TODO temp only
  // TODO this should be handled by some controller that handles join unjoin
  // TODO make issue out of this
  // CurrentPlayerToggleMatchParticiptionController
  bool isParticipating = true;
  Future<void> onParticipateToggle() async {
    final value = isParticipating;
    setState(() {
      isParticipating = !value;
    });
  }

  // TODO we will see if this stays forever
  // TODO move below
  // bool check

  @override
  Widget build(
    BuildContext context,
  ) {
    final matchControllerState = ref.watch(getMatchControllerProviderInstance);
    final matchUIState = _getMatchUIState(matchControllerState);
    final togglerOptions = _getTogglerOptions(
      matchUIState: matchUIState,
      // onRetry: onMatchReload,
      onRetry: () async {
        // TODO come back to this
        // await onMatchReload();
      },
    );

    // TODO maybe better it would be here to have controllers to join and unjoin - we will see

    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,
      // TODO make ticket for abnstracting app bar to be reusable
      appBar: AppBar(
        // TODO make ticket to creae app bar same everywhere, or color at least
        // TODO use theme
        backgroundColor: ColorConstants.BLUE_LIGHT,
        actions: [
          // TODO this should be handled by some controller that handles join unjoin
          CurrentPlayerMatchParticipationIndicator(
            // isParticipating: isParticipating,
            // onParticipateToggle: onParticipateToggle,
            // participations: matchUIState.match?.participations ?? [],
            participations: matchUIState.match?.participations,
            matchId: widget.matchId,
            onReloadMatch: () {
              // TODO for now lets keep it like this
              ref
                  .read(getMatchControllerProviderInstance.notifier)
                  .onGetMatch();
            },
          ),
        ],
      ),
      body: TabToggler(
        options: togglerOptions,
        backgroundColor: ColorConstants.WHITE,
      ),
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchUIState matchUIState,
    required Future<void> Function() onRetry,
  }) {
    final match = matchUIState.match;
    // TODO this will need to be updated once backend provides arriving players
    // TODO this will need to be derived from match data - so we will need to provide arriving players on match model - will need to be joining some stuff on backend - and will need to be migrating db here
    // TODO this seems to be the best - let mobile app database always have ready for render data, so it does not have to do any joins on its own - otherwise, joining implementations might be different, and all goes to shit
    // final participants = _tempMatchParticipants;
    final isLoading = matchUIState.isLoading;
    final isError = matchUIState.isError;
    final isSyncing = matchUIState.isSyncing;

    return [
      TabTogglerOptionValue(
        title: "INFO",
        child: MatchInfoContainer(
          match: match,
          isError: isError,
          isLoading: isLoading,
          isSyncing: isSyncing,
          onRetry: onRetry,
        ),
      ),
      TabTogglerOptionValue(
        title: "PARTICIPANTS",
        child: MatchParticipantsContainer(
          // participants: participants,
          participants: match?.participations,
          isError: isError,
          isLoading: isLoading,
          isSyncing: isSyncing,
        ),
      ),
    ];
  }

  MatchUIState _getMatchUIState(
    AsyncValue<GetMatchControllerState> matchControllerState,
  ) {
    final isLoading = matchControllerState.maybeWhen(
      orElse: () => false,
      loading: () => true,
    );

    final isSyncing = matchControllerState.maybeWhen(
      orElse: () => false,
      data: (data) => !data.isRemoteFetchDone,
    );

    final isError = matchControllerState.maybeWhen(
      orElse: () => false,
      error: (error, stackTrace) => true,
    );

    final match = matchControllerState.maybeWhen(
      orElse: () => null,
      data: (state) => state.match,
    );

    return MatchUIState(
      isLoading: isLoading,
      isSyncing: isSyncing,
      isError: isError,
      match: match,
    );
  }
}

class CurrentPlayerMatchParticipationIndicator extends ConsumerWidget {
  const CurrentPlayerMatchParticipationIndicator({
    super.key,
    required this.participations,
    required this.matchId,
    required this.onReloadMatch,
    // required this.isParticipating,
    // required this.onParticipateToggle,
  });

  // final bool isParticipating;
  // final Future<void> Function() onParticipateToggle;

  // TODO this widget itself should hold three controllers
  // get authenticated player model
  // join match
  // unjoin match

  // it should receive match participations and check if authenticated player is in it

  final List<PlayerMatchParticipationModel>? participations;
  final int matchId;
  // TODO this is a bit clumsy now - maybe logic for toggling participation of current user should be inside the main widget, and then single function would we bpassed here that has both toggle participation and reload match?
  final VoidCallback onReloadMatch;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final authenticatedPlayerModelState =
        ref.watch(getAuthenticatedPlayerControllerProvider);

    final isLoading = authenticatedPlayerModelState.isLoading;
    final isError = authenticatedPlayerModelState.hasError;
    final authenticatedPlayer =
        authenticatedPlayerModelState.value?.authenticatedPlayer;

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (isError) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: Text("N/A")),
      );
    }

    if (authenticatedPlayer == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final thisParticipations = participations;
    if (thisParticipations == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final isParticipating = _checkIsParticipating(
      authenticatedPlayer: authenticatedPlayer,
      participations: thisParticipations,
    );

    // TODO this needs to be be rebuilt once toggled. so the match needs to be updated. so i guess we need to reload the match
    final String label = isParticipating ? "JOINED" : "JOIN";
    final Icon icon = isParticipating
        ? const Icon(
            Icons.check_circle,
            color: ColorConstants.BLUE_DARK,
          )
        : const Icon(
            Icons.add_circle,
            color: ColorConstants.ORANGE,
          );

    return TextButton.icon(
      onPressed: () => _handleParticipateToggle(
        ref: ref,
        isParticipating: isParticipating,
        // authenticatedPlayer: authenticatedPlayer,
        // matchId: this.first.matchId,
        matchId: matchId,
      ),
      label: icon,
      icon: Text(label),
    );
  }

  bool _checkIsParticipating({
    required AuthenticatedPlayerModel authenticatedPlayer,
    required List<PlayerMatchParticipationModel> participations,
  }) {
    final isParticipating = participations.any(
      (participation) =>
          participation.playerId == authenticatedPlayer.playerId &&
          participation.status == PlayerMatchParticipationStatus.arriving,
    );

    return isParticipating;
  }

  Future<void> _handleParticipateToggle({
    required WidgetRef ref,
    required bool isParticipating,
    // required AuthenticatedPlayerModel authenticatedPlayer,
    required int matchId,
  }) async {
    if (isParticipating) {
      // TODO unjoin match

      await ref.read(unjoinMatchControllerProvider.notifier).onUnjoinMatch(
            matchId: matchId,
          );
    } else {
      // TODO join match

      await ref.read(joinMatchControllerProvider.notifier).onJoinMatch(
            matchId: matchId,
          );
    }

    // TODO this should probably be done in parent of this widget, or in .listen of the state of both controllers
    onReloadMatch();
  }
}

// TODO only temp this until we get arriving players on the match itself
// TODO not sure if we should have another model for participant where it would have som field on it to indicate match that it is partipaating in - but it would be a n overkjill it seems
final List<PlayerModel> _tempMatchParticipants = List.generate(
  12,
  (index) => PlayerModel(
    id: index + 1,
    name: "Player name_$index",
    avatarUri:
        Uri.parse("https://images.unsplash.com/photo-1554151228-14d9def656e4"),
    nickname: "Player nickname_$index",
  ),
);
