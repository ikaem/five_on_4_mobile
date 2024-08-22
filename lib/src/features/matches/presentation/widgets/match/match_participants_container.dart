import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/circled_sides_avatar.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/core/utils/extensions/string_extension.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_list.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

class MatchParticipantsContainer extends StatelessWidget {
  const MatchParticipantsContainer({
    super.key,
    required this.participants,
    required this.isError,
    required this.isLoading,
    required this.isSyncing,
  });

// TODO possible that we would need to introduce a model for participant
  final List<PlayerModel> participants;
  final bool isError;
  final bool isSyncing;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const ErrorStatus(
        message: "There was an issue loading match participants",
        onRetry: null,
      );
    }

    if (isLoading) {
      return const LoadingStatus(message: "Loading match participants...");
    }

    return MatchParticipants(players: participants);

    // return Container();

    // TODO old
    // if (participants.isEmpty) {
    //   return const Column(
    //     children: [
    //       Text("No participants"),
    //       Text("Why not invite some?"),
    //     ],
    //   );
    // }

    // return MatchParticipantsList(participants: participants);
  }
}

// TODO move to its own widget - but also, maybe unite with match create solution for similar functionality
class MatchParticipants extends StatelessWidget {
  const MatchParticipants({
    super.key,
    required this.players,
  });

  final List<PlayerModel> players;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return Column(
        children: [
          const Text(
            "No players have been invited to the match",
            style: TextStyle(
              fontSize: TextSizeConstants.EXTRA_LARGE,
              color: ColorConstants.BLUE_DARK,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpacingConstants.XS),
          const Text(
            "Why don't you reach out to some?",
            style: TextStyle(
              fontSize: TextSizeConstants.LARGE,
              color: ColorConstants.BLACK,
            ),
          ),
          const SizedBox(height: SpacingConstants.L),
          // TODO this could potentially be a sheet - maybe no need to be a dialog
          CustomElevatedButton(
            buttonColor: ColorConstants.BLUE_DARK,
            textColor: ColorConstants.WHITE,
            labelText: "INVITE PLAYERS",
            // onPressed: () => _onShowplayersInviteDialog(context: context),
            onPressed: () {},
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO this will need button to add new players
        // invitePlayersButton,
        CustomElevatedButton(
          buttonColor: ColorConstants.BLUE_DARK,
          textColor: ColorConstants.WHITE,
          labelText: "INVITE PLAYERS",
          // onPressed: () => _onShowplayersInviteDialog(context: context),
          onPressed: () {},
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
        const SizedBox(height: SpacingConstants.XS),
        const Text(
          "CURRENT PARTICIPANTS",
          // textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: TextSizeConstants.SMALL,
            fontWeight: FontWeight.bold,
            color: ColorConstants.GREY,
          ),
        ),
        const SizedBox(height: SpacingConstants.L),

        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: SpacingConstants.XL,
              child: Divider(),
            ),
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];

              return MatchPlayerParticipation(
                player: player,
                // isAddedToMatchInvitations: true,
                // onInvitationAction: ({
                //   required PlayerModel player,
                // }) {
                //   // TODO should do some stuff - not sure where is this going to be passed from
                // },
              );
            },
          ),
        ),
      ],
    );
  }
}

// TODO also reuse this possibly with match create participants - or replace existing match participation invitation  - because it is not rellay invitation - it is participation - not necessarily joined, but participation still
// TODO move to correct folder
// TODO should this be converted to player brief - and then we just pass actions as we see fit? - and some labels too - so we can pass condtional labels as widgets? we will see
class MatchPlayerParticipation extends StatelessWidget {
  const MatchPlayerParticipation({
    super.key,
    required this.player,
  });

  // TODO we dont necessarily allow any actions here - it should be custom - we will add this later as a separate widget
  // that widgetion will MatchParticipantActions

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    // TODO here will will conditoonally later render MatchParticipantActionsSelector in case there are any actions available
    // TODO this could theoretically render PlayerBrief, and then potentially add this action thing - we will see later
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     CircledSidesAvatar(
        //       avatarUri: player.avatarUri,
        //       // TODO WE SHOULD HAVE SOME CONSTANT HERE
        //       radius: 50,
        //     ),
        //     const SizedBox(
        //       height: 5,
        //     ),
        //     GestureDetector(
        //       onTap: () {},
        //       child: const Icon(
        //         Icons.more_horiz,
        //         color: ColorConstants.BLUE_DARK,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   width: SpacingConstants.M,
        // ),
        Expanded(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.nickname,
                style: const TextStyle(
                  fontSize: TextSizeConstants.LARGE,
                  color: ColorConstants.BLACK,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: SpacingConstants.XS),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: ColorConstants.BLUE_DARK,
                  ),
                  const SizedBox(width: SpacingConstants.XS),
                  Text(
                    player.name.uppercase,
                    style: const TextStyle(
                      color: ColorConstants.BLACK,
                      fontSize: TextSizeConstants.REGULAR,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SpacingConstants.XS),
              const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: ColorConstants.BLUE_DARK,
                  ),
                  SizedBox(width: SpacingConstants.XS),
                  Text(
                    "Player team name",
                    style: TextStyle(
                      color: ColorConstants.BLACK,
                      fontSize: TextSizeConstants.REGULAR,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: SpacingConstants.M,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircledSidesAvatar(
              avatarUri: player.avatarUri,
              // TODO WE SHOULD HAVE SOME CONSTANT HERE
              radius: 50,
            ),
            const SizedBox(
              height: 5,
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: const Icon(
            //     Icons.more_horiz,
            //     color: ColorConstants.BLUE_DARK,
            //   ),
            // ),
            SizedBox(
              height: 30,
              child: PopupMenuButton(
                color: ColorConstants.BLUE_DARK,
                // iconSize: 14,
                padding: const EdgeInsets.all(1),
                icon: const Icon(
                  // size: 14,
                  Icons.more_horiz,
                  color: ColorConstants.BLUE_DARK,
                ),
                itemBuilder: (BuildContext context) {
                  return _tempActionItems.map((item) {
                    return PopupMenuItem(
                      value: item.onActionItemTap(),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: ColorConstants.GREY_LIGHT,
                          ),
                          const SizedBox(width: SpacingConstants.XS),
                          Text(
                            item.label,
                            style: const TextStyle(
                              color: ColorConstants.WHITE,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList();

                  // return [
                  //   const PopupMenuItem(
                  //     child: Text(
                  //       "Invite player",
                  //       style: TextStyle(
                  //         color: ColorConstants.WHITE,
                  //       ),
                  //     ),
                  //   ),
                  //   const PopupMenuItem(
                  //     child: Text(
                  //       "View player",
                  //       style: TextStyle(
                  //         color: ColorConstants.WHITE,
                  //       ),
                  //     ),
                  //   ),
                  // ];
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// TODO move somewhere else
// TODO test
class PlayerBriefActionItem<T> {
  const PlayerBriefActionItem({
    required this.label,
    required this.icon,
    required this.onActionItemTap,
  });

  final String label;
  final IconData icon;
  final T Function() onActionItemTap;
}

// TODO temp only
List<PlayerBriefActionItem> _tempActionItems = [
  PlayerBriefActionItem<void>(
    label: "Invite player",
    icon: Icons.add,
    onActionItemTap: () {},
  ),
  PlayerBriefActionItem<void>(
    label: "View player",
    icon: Icons.person,
    onActionItemTap: () {},
  ),
];
