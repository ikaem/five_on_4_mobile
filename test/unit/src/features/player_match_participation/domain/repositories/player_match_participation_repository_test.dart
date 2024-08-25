import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_remote/player_match_participation_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/repositories/player_match_participation_repository.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/repositories/player_match_participation_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final playerMatchParticipationRemoteDataSource =
      _MockPlayerMatchParticipationRemoteDataSource();

  // tested class
  final repository = PlayerMatchParticipationRepositoryImpl(
    playerMatchParticipationRemoteDataSource:
        playerMatchParticipationRemoteDataSource,
  );

  tearDown(() {
    reset(playerMatchParticipationRemoteDataSource);
  });

  group(
    "$PlayerMatchParticipationRepository",
    () {
      group(
        ".inviteToMatch()",
        () {
          test(
            "given match is invited successfully"
            "when [.inviteToMatch()] is called"
            "then should return expected id of match participation",
            () async {
              // setup
              const participationId = 1;

              // given
              when(
                () => playerMatchParticipationRemoteDataSource.inviteToMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => participationId,
              );

              // when
              final result = await repository.inviteToMatch(
                matchId: 1,
                playerId: 1,
              );

              // then
              expect(result, equals(participationId));

              // cleanup
            },
          );

          test(
            "given [playerId] and [matchId]"
            "when [.inviteToMatch()] is called"
            "then should call [PlayerMatchParticipationRemoteDataSource.inviteToMatch()] with expected arguments",
            () async {
              // setup
              when(
                () => playerMatchParticipationRemoteDataSource.inviteToMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const matchId = 1;
              const playerId = 1;

              // when
              await repository.inviteToMatch(
                matchId: matchId,
                playerId: playerId,
              );

              // then
              verify(
                () => playerMatchParticipationRemoteDataSource.inviteToMatch(
                  matchId: matchId,
                  playerId: playerId,
                ),
              ).called(1);

              // cleanup
            },
          );
        },
      );

      group(
        ".unjoinMatch()",
        () {
          test(
            "given match is unjoined successfully"
            "when [.unjoinMatch()] is called"
            "then should return expected id of match participation",
            () async {
              // setup
              const participationId = 1;

              // given
              when(
                () => playerMatchParticipationRemoteDataSource.unjoinMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => participationId,
              );

              // when
              final result = await repository.unjoinMatch(
                matchId: 1,
                playerId: 1,
              );

              // then
              expect(result, equals(participationId));

              // cleanup
            },
          );

          test(
            "given [playerId] and [matchId]"
            "when [.unjoinMatch()] is called"
            "then should call [PlayerMatchParticipationRemoteDataSource.unjoinMatch()] with expected arguments",
            () async {
              // setup
              when(
                () => playerMatchParticipationRemoteDataSource.unjoinMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const matchId = 1;
              const playerId = 1;

              // when
              await repository.unjoinMatch(
                matchId: matchId,
                playerId: playerId,
              );

              // then
              verify(
                () => playerMatchParticipationRemoteDataSource.unjoinMatch(
                  matchId: matchId,
                  playerId: playerId,
                ),
              ).called(1);

              // cleanup
            },
          );
        },
      );

      group(
        ".joinMatch()",
        () {
          test(
            "given match is joined successfully"
            "when [.joinMatch()] is called"
            "then should return expected id of the match participation",
            () async {
              // setup
              const participationId = 1;

              // given
              when(
                () => playerMatchParticipationRemoteDataSource.joinMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => participationId,
              );

              // when
              final result = await repository.joinMatch(
                matchId: 1,
                playerId: 1,
              );

              // then
              expect(result, equals(participationId));

              // cleanup
            },
          );

          test(
            "given [playerId] and [matchId]"
            "when [.joinMatch()] is called"
            "then should call [PlayerMatchParticipationRemoteDataSource.joinMatch()] with expected arguments",
            () async {
              // setup
              when(
                () => playerMatchParticipationRemoteDataSource.joinMatch(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const matchId = 1;
              const playerId = 1;

              // when
              await repository.joinMatch(
                matchId: matchId,
                playerId: playerId,
              );

              // then
              verify(
                () => playerMatchParticipationRemoteDataSource.joinMatch(
                  matchId: matchId,
                  playerId: playerId,
                ),
              ).called(1);

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockPlayerMatchParticipationRemoteDataSource extends Mock
    implements PlayerMatchParticipationRemoteDataSource {}
