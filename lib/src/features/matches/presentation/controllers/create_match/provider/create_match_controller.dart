import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/match_create_converter.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "create_match_controller.g.dart";
part "create_match_controller_state.dart";

// TODO not sure if this should be here? it probably should...

// TODO THIS SHOULD all be tested properly

@riverpod
class CreateMatchController extends _$CreateMatchController {
  // late final CreateMatchUseCase createMatchUseCase = ref.read(
  //   createMatchUseCaseProvider,
  // );
  // late final GetAuthDataStatusUseCase getAuthDataStatusUseCase = ref.read(
  //   getAuthDataStatusUseCaseProvider,
  // );
  // TODO uncomment when logout is implemented
  // late final LogoutUseCase logoutUseCase = ref.read(
  //   logoutUseCaseProvider,
  // );

  final CreateMatchUseCase _createMatchUseCase =
      GetItWrapper.get<CreateMatchUseCase>();
  final GetAuthenticatedPlayerModelUseCase _getAuthenticatedPlayerModelUseCase =
      GetItWrapper.get<GetAuthenticatedPlayerModelUseCase>();
  final SignOutUseCase _signOutUseCase = GetItWrapper.get<SignOutUseCase>();
  // final getAuthDataStatusUseCase = GetItWrapper.get<GetAuthDataStatusUseCase>();

  @override
  AsyncValue<CreateMatchControllerState?> build() {
    // TODO some handle dispose stuff here as well?
    // TODO maybe it does not need to be AsyncValue? - maybe it woulkd work with .when even with regular data?
    return const AsyncValue.data(null);

    // nothing needed on initialization
  }

  Future<void> onCreateMatch(MatchCreateInputArgs? createMatchArgs) async {
    if (createMatchArgs == null) {
      return;
    }
    state = const AsyncValue.loading();
    try {
      // TODO maybe it is good to delegate this generation of Value to use case
      // TODO this would mean that use case would retrieve authdata? not sure about it? maybe it is fine?
      // final authData = await getAuthDataStatusUseCase();
      // if (authData == null) {
      //   throw const AuthNotLoggedInException();
      // }
      final authenticatedPlayer = await _getAuthenticatedPlayerModelUseCase();
      if (authenticatedPlayer == null) {
        throw const AuthNotLoggedInException();
        // state = const AsyncValue.error(
        //   "User is not logged in",
        //   // TODO stack trace should be handled better here - not empty
        //   StackTrace.empty,
        // );
        // return;
      }

      final MatchCreateDataValue matchCreateData =
          MatchCreateConverter.valueFromArgsAndOrganizer(
        args: createMatchArgs,
        // TODO THIS SHOULD EVENTUALLY PROBABLY accept id of organizer - not string - and then it could also be handled on backend too
        // organizer: authData.nickName,
        organizer: authenticatedPlayer.playerNickname,
      );

      final matchId = await _createMatchUseCase(matchData: matchCreateData);
      state = AsyncValue.data(CreateMatchControllerState(matchId: matchId));
    } on AuthNotLoggedInException catch (e, s) {
      log("There was an auth issue when creating match -> error: $e, stack: $s");
      state = const AsyncValue.error("User is not logged in", StackTrace.empty);

      // TODO need to do this when logout is implemented
      await _signOutUseCase();
    } catch (e, s) {
      log("Error creating match -> error: $e, stack: $s");
      state = const AsyncValue.error(
        "There was an issue creating the match",
        // TODO we dont really want to set state of stack trace - we will load this - so empty is ok
        StackTrace.empty,

        // s,
      );
    }
  }
}
