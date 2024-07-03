import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/provider/get_auth_data_status_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/create_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/create_match/provider/create_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/match_create_converter.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter/material.dart';
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

  final createMatchUseCase = GetItWrapper.get<CreateMatchUseCase>();
  final getAuthDataStatusUseCase = GetItWrapper.get<GetAuthDataStatusUseCase>();

  @override
  AsyncValue<CreateMatchControllerState?> build() {
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
      final authData = await getAuthDataStatusUseCase();
      if (authData == null) {
        throw const AuthNotLoggedInException();
      }

      final matchCreateData = MatchCreateConverter.valueFromArgsAndOrganizer(
        args: createMatchArgs,
        organizer: authData.nickName,
      );

      final matchId = await createMatchUseCase(matchData: matchCreateData);
      state = AsyncValue.data(CreateMatchControllerState(matchId: matchId));
    } on AuthNotLoggedInException catch (e, s) {
      log("There was aan auth issue when creating match -> error: $e, stack: $s");
      state = const AsyncValue.error("User is not logged in", StackTrace.empty);

      // TODO need to do this when logout is implemented
      // await logoutUseCase();
    } catch (e, s) {
      log("Error creating match -> error: $e, stack: $s");
      state = const AsyncValue.error(
        "There was an issue creating the match",
        StackTrace.empty,

        // s,
      );
    }
  }
}
