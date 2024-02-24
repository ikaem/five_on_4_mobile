import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/constants/http_matches_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/data/test_values.dart';

void main() {
  // TODO we will try not to expose it via riverpod
  final dioWrapper = _MockDioWrapper();
  // final dioWrapper = DioWrapper(interceptor: DioInterceptor());
  final matchesRemoteDataSource = MatchesRemoteDataSourceImpl(
    dioWrapper: dioWrapper,
  );

  setUpAll(() {
    registerFallbackValue(_FakeHttpRequestUriPartsValue());
  });

  tearDown(() {
    reset(dioWrapper);
  });

  group(
    "MatchesRemoteDataSource",
    () {
      group(
        ".createMatch()",
        () {
          test(
            "given valid $MatchCreateDataValue argument is passed "
            "when call '.createMatch()'"
            "then should return expected match id",
            () async {
              const matchId = 1;
              when(
                () => dioWrapper.post<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                  bodyData: any(named: "bodyData"),
                ),
              ).thenAnswer(
                (_) async {
                  return {
                    "ok": true,
                    "data": matchId,
                  };
                },
              );

              // Given
              final createMatchValue = getTestMatchCreateValues(count: 1).first;

              // When
              final id = await matchesRemoteDataSource.createMatch(
                matchData: createMatchValue,
              );

              // Then
              expect(id, equals(matchId));
            },
          );
        },
      );
      group(
        ".getMatch()",
        () {
          test(
            "given a match id"
            "when call '.getMatch()'"
            "then should return expected match",
            () async {
              final testMatch = getTestMatchRemoteEntities().first;
              final testMatchJson = testMatch.toJson();
              final matchResponse = {
                "ok": true,
                "data": testMatchJson,
              };

              when(
                () => dioWrapper.get<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                ),
              ).thenAnswer((invocation) async => matchResponse);

              final match = await matchesRemoteDataSource.getMatch(
                matchId: testMatch.id,
              );

              expect(match, equals(testMatch));
            },
          );

          test(
            "given a match request"
            "when call '.getMatch()'"
            "then should call dioWrapper with expected arguments",
            () async {
              final testMatch = getTestMatchRemoteEntities().first;
              final testMatchJson = testMatch.toJson();
              final matchResponse = {
                "ok": true,
                "data": testMatchJson,
              };

              final matchId = testMatch.id;

              when(
                () => dioWrapper.get<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                ),
              ).thenAnswer((invocation) async => matchResponse);

              final expectedUriPartsArgs = HttpRequestUriPartsValue(
                // TODO use https when we have real server eventually
                apiUrlScheme: HttpConstants.HTTP_PROTOCOL.value,
                port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
                apiBaseUrl: HttpConstants.BACKEND_BASE_URL_FAKE.value,
                apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH_FAKE.value,
                apiEndpointPath: HttpMatchesConstants
                    .BACKEND_ENDPOINT_PATH_MATCH
                    .getMatchPathWithId(matchId),
                queryParameters: null,
              );

              await matchesRemoteDataSource.getMatch(
                matchId: testMatch.id,
              );

              verify(
                () => dioWrapper.get<Map<String, dynamic>>(
                  uriParts: expectedUriPartsArgs,
                ),
              );
            },
          );
        },
      );
      group(
        // TODO rename this to loadMyFollowingMatches
        ".getMyFollowingMatches()",
        () {
          test(
            "given nothing in particular"
            "when '.getMyFollowingMatches() is called"
            "should return expected list of matches",
            () async {
              final testMatches = getTestMatchRemoteEntities(count: 1);

              final testMatchesJson =
                  testMatches.map((match) => match.toJson()).toList();
              final matchesResponse = {
                "ok": true,
                "data": testMatchesJson,
              };

              when(
                () => dioWrapper.get<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                ),
              ).thenAnswer(
                (_) async {
                  return matchesResponse;
                },
              );

              // TODO we should also test that correct arguments are used

              final matches =
                  await matchesRemoteDataSource.getPlayerInitialMatches();

              expect(matches, equals(testMatches));
            },
          );
        },

        // TODO test interceptor that adds auth header - but this is is a different test - and later we can use that to get my matches, and not manually pass user idÞ
      );
    },
  );
}

class _MockDioWrapper extends Mock implements DioWrapper {}

class _FakeHttpRequestUriPartsValue extends Fake
    implements HttpRequestUriPartsValue {}

// TODO just temp until we go to real server
List<MatchRemoteEntity> _generateTempManipulatedMatches(
    List<MatchRemoteEntity> matchesEntities) {
  final manipulatedMatchesToSplitBetweenTodayAndTomorrow = matchesEntities.map(
    (match) {
      final matchesLength = matchesEntities.length;
      final isInFirstHalf = matchesEntities.indexOf(match) < matchesLength / 2;

      final manipulatedDate = isInFirstHalf
          ? DateTime.now().millisecondsSinceEpoch
          : DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;

      final manipulatedMatch = MatchRemoteEntity(
        id: match.id,
        date: manipulatedDate,
        arrivingPlayers: match.arrivingPlayers,
        description: match.description,
        location: match.location,
        name: match.name,
        organizer: match.organizer,
      );

      return manipulatedMatch;
    },
  ).toList();

  return manipulatedMatchesToSplitBetweenTodayAndTomorrow;
}
