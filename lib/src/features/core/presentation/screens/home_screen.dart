// TODO dont forget to test this

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/provider/auth_status_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_events_when_toggler.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/current_user/current_user_greeting.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/dialog_wrapper.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_invite_form.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // const Text("Home Screen"),
            // ElevatedButton(
            //   onPressed: () {
            //     // TODO make some extension to make sure "/" is added in front of the route automatically
            //     context.go("/${RoutePathsConstants.MATCH.value}");
            //   },
            //   child: const Text("Go to match"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     // ref.read(authStatusDataSourceProvider).setAuthDataStatus(null);
            //   },
            //   child: const Text("Logout"),
            // ),
            ElevatedButton(
              onPressed: () async {
                // ref.read(authStatusDataSourceProvider).setAuthDataStatus(null);

                await showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrapper(
                      title: "title",
                      child: Container(
                        child: MatchCreateParticipantsInviteForm(
                          foundPlayers: List.generate(10, (index) {
                            return PlayerModel(
                              id: index,
                              name: "Player $index",
                              nickname: "Player $index",
                              avatarUri: Uri.parse(
                                  "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
                            );
                          }),
                          onPlayerSearch: (
                              {required String playerIdentifier}) async {},
                          onInvitationAction: (
                              {required PlayerModel player}) {},
                        ),
                      ),
                    );

                    // return Dialog(
                    //   backgroundColor: const Color.fromARGB(255, 160, 197, 227),
                    //   // TODO create some dialog wrapper for this
                    //   child: Container(
                    //     child: Column(
                    //       children: [
                    //         // TODO this is the upper part
                    //         Row(
                    //           children: [
                    //             const Expanded(
                    //                 child: Text("This is title part")),
                    //             IconButton(
                    //               onPressed: () {
                    //                 Navigator.of(context).pop();
                    //               },
                    //               icon: const Icon(
                    //                 Icons.close_rounded,
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //         // TODO this is now the content that we are wrapping here
                    //         Expanded(
                    //           // child: Text("Hello"),
                    //           child: Container(
                    //             child: MatchCreateParticipantsInviteForm(
                    //               foundPlayers: List.generate(10, (index) {
                    //                 return PlayerModel(
                    //                   id: index,
                    //                   name: "Player $index",
                    //                   nickname: "Player $index",
                    //                   avatarUri: Uri.parse(
                    //                       "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
                    //                 );
                    //               }),
                    //               onPlayerSearch: (
                    //                   {required String
                    //                       playerIdentifier}) async {},
                    //               onInvitationAction: (
                    //                   {required PlayerModel player}) {},
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );

                    // return const SimpleDialog(
                    //   title: Text("Simple Dialog"),
                    //   children: [
                    //     Text("This is a simple dialog"),
                    //   ],
                    // );

                    //
                    // return const AboutDialog(
                    //   applicationIcon: FlutterLogo(),
                    //   applicationName: "Five on 4",
                    //   applicationVersion: "0.0.1",
                    //   children: [
                    //     Text("This is a test"),
                    //   ],
                    // );

                    //
                    // return AlertDialog(
                    //   title: const Text("Dialog"),
                    //   content: const Text("Dialog content"),
                    //   actions: [
                    //     TextButton(
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //       },
                    //       child: const Text("Close"),
                    //     ),
                    //   ],
                    // );
                  },
                );
              },
              child: const Text("Open dialog"),
            ),
            CurrentUserGreeting(
              nickName: "nickName",
              teamName: "teamName",
              avatarUrl: Uri.parse(
                  "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
            ),
            // Expanded(
            //   child: DialogWrapper(
            //     title: "Test",
            //     child: Container(
            //       child: MatchCreateParticipantsInviteForm(
            //         foundPlayers: List.generate(10, (index) {
            //           return PlayerModel(
            //             id: index,
            //             name: "Player $index",
            //             nickname: "Player $index",
            //             avatarUri: Uri.parse(
            //                 "https://images.unsplash.com/photo-1554151228-14d9def656e4"),
            //           );
            //         }),
            //         onPlayerSearch: (
            //             {required String playerIdentifier}) async {},
            //         onInvitationAction: ({required PlayerModel player}) {},
            //       ),
            //     ),
            //   ),
            // ),
            const Expanded(
              child: CurrentUserEventsWhenToggler(
                matchesToday: [],
                matchesFollowing: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
