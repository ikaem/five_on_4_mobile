import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/exceptions/match_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/constants/http_matches_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/matchers/throws_exception_with_message.dart';

void main() {
  final dioWrapper = _MockDioWrapper();

  // tested class
  final dataSource = MatchesRemoteDataSourceImpl(dioWrapper: dioWrapper);

  setUpAll(() {
    registerFallbackValue(_FakeHttpRequestUriPartsValue());
    registerFallbackValue(HttpMethodConstants.GET);
  });

  tearDown(() {
    reset(dioWrapper);
  });

  group(
    "$MatchesRemoteDataSource",
    () {
      group(".createMatch()", () {
        final okResponseMap = {
          "ok": true,
          "mssage": "Match created successfully.",
          "data": {
            "matchId": 1,
          }
        };

        final nonOkResponseMap = {
          "ok": false,
          "message": "Match failed to create.",
        };

        const MatchCreateDataValue testMatchCreateValue = MatchCreateDataValue(
          name: "name",
          location: "location",
          organizer: "organizer",
          description: "description",
          invitedPlayers: [],
          dateTime: 1,
        );

        // should return response when ok
        test(
          "given ok response from backend"
          "when .createMatch() is called"
          "then should return expected response",
          () async {
            // setup

            // given
            when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                  method: any(named: "method"),
                  bodyData: any(named: "bodyData"),
                )).thenAnswer((_) async {
              return HttpResponseValue(payload: okResponseMap);
            });

            // when
            final matchId = await dataSource.createMatch(
              matchData: testMatchCreateValue,
            );

            // then
            expect(matchId, equals(1));

            // cleanup
          },
        );

        // should call dio requzest with expected arguments
        test(
          "given .createMatch() is called"
          "when examine request to the server"
          "then should call DioWrapper.makeRequest() with expected arguments",
          () async {
            // setup
            final uriParts = HttpRequestUriPartsValue(
              apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
              apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
              apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
              apiEndpointPath:
                  HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH_CREATE.value,
              queryParameters: null,
            );
            const method = HttpMethodConstants.POST;
            final bodyData = {
              "title": testMatchCreateValue.name,
              "location": testMatchCreateValue.location,
              "description": testMatchCreateValue.description,
              "dateAndTime": testMatchCreateValue.dateTime,
            };

            when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: uriParts,
                  method: method,
                  bodyData: any(named: "bodyData"),
                )).thenAnswer((_) async {
              return HttpResponseValue(payload: okResponseMap);
            });

            // given
            await dataSource.createMatch(
              matchData: testMatchCreateValue,
            );

            // when
            verify(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: uriParts,
                  method: method,
                  bodyData: bodyData,
                )).called(1);

            // then

            // cleanup
          },
        );

        // TODO also handle errors somehow - error is created and it exists
        test(
          "given a non-ok response from backend"
          "when .createMatch() is called"
          "then should throw expected exception",
          () async {
            // setup
            // TODO note that this will not happe because how backend is set up and how dio is set up - dio will throw exception if not ok becasue non-ok responses have error status codes

            // given
            when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                  method: any(named: "method"),
                  bodyData: any(named: "bodyData"),
                )).thenAnswer((_) async {
              return HttpResponseValue(payload: nonOkResponseMap);
            });

            // when / then
            expect(
              () async {
                await dataSource.createMatch(
                  matchData: testMatchCreateValue,
                );
              },
              // throwsA(isA<Exception>()),
              throwsExceptionWithMessage<MatchesExceptionMatchFailedToCreate>(
                "Failed to create match",
              ),
            );

            // then

            // cleanup
          },
        );
      });

      group(".getPlayerMatchesOverview()", () {
        // on ok response, return expected response
        test(
          "given ok response from dio"
          "when .getPlayerMatchesOverview() is called"
          "then should return expected response",
          () async {
            // setup
            final matchEntities = generateTestMatchRemoteEntities(count: 3);

            // given
            when(
              () => dioWrapper.makeRequest<Map<String, dynamic>>(
                uriParts: any(named: "uriParts"),
                method: any(named: "method"),
                bodyData: any(named: "bodyData"),
              ),
            ).thenAnswer(
              (_) async {
                return HttpResponseValue(payload: {
                  "ok": true,
                  "message": "Player matches overview retrieved successfully.",
                  "data": {
                    "matches": matchEntities
                        .map((e) => {
                              "id": e.id,
                              "title": e.title,
                              "dateAndTime": e.dateAndTime,
                              "location": e.location,
                              "description": e.description,
                            })
                        .toList(),
                  }
                });
              },
            );

            // when
            final matches = await dataSource.getPlayerMatchesOverview(
              playerId: 1,
            );

            // then
            expect(matches, equals(matchEntities));

            // cleanup
          },
        );

        // call dio with expected arguments
        test(
          "given .getPlayerMatchesOverview() is called"
          "when examine request to the server"
          "then should call DioWrapper.makeRequest() with expected arguments",
          () async {
            // setup
            // TODO maybe not needed to do this and to capture then? maybe can just do when with expected arguments
            final expectedUriParts = HttpRequestUriPartsValue(
              // TODO use https when we have real server eventually
              apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
              // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
              apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
              apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
              apiEndpointPath: HttpMatchesConstants
                  .BACKEND_ENDPOINT_PATH_MATCHES_PLAYER_MATCHES_OVERVIEW.value,
              queryParameters: null,
            );
            const expectedMethod = HttpMethodConstants.GET;
            when(
              () => dioWrapper.makeRequest<Map<String, dynamic>>(
                uriParts: any(named: "uriParts"),
                method: any(named: "method"),
                bodyData: any(named: "bodyData"),
              ),
            ).thenAnswer(
              (_) async {
                return HttpResponseValue(payload: {
                  "ok": true,
                  "message": "Player matches overview retrieved successfully.",
                  "data": {"matches": <Map<String, Object>>[]}
                });
              },
            );

            // given
            await dataSource.getPlayerMatchesOverview(
              playerId: 1,
            );

            // when
            final captured = verify(
              () => dioWrapper.makeRequest<Map<String, dynamic>>(
                uriParts: captureAny(named: "uriParts"),
                method: captureAny(named: "method"),
                bodyData: captureAny(named: "bodyData"),
              ),
            ).captured;

            // then
            final actualUriParts = captured[0] as HttpRequestUriPartsValue;
            final actualMethod = captured[1] as HttpMethodConstants;
            final actualBodyData = captured[2];

            print("what");

            expect(actualUriParts, equals(expectedUriParts));
            expect(actualMethod, equals(expectedMethod));
            expect(
                actualBodyData,
                equals({
                  "player_id": 1,
                }));

            // cleanup
          },
        );

        // TODO on non-ok response, throw exception - not sure how to test this or what the bahavior should be - lets wait
      });
    },
  );
}

class _MockDioWrapper extends Mock implements DioWrapper {}

class _FakeHttpRequestUriPartsValue extends Fake
    implements HttpRequestUriPartsValue {}






//  ------------ OLD -------------
// TODO come back to this

// import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
// import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source_impl.dart';
// import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
// import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
// import 'package:five_on_4_mobile/src/features/matches/utils/constants/http_matches_constants.dart';
// import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
// import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../../../../utils/data/test_entities.dart';
// import '../../../../../../../utils/data/test_values.dart';

// void main() {
//   // TODO we will try not to expose it via riverpod
//   final dioWrapper = _MockDioWrapper();
//   // final dioWrapper = DioWrapper(interceptor: DioInterceptor());
//   final matchesRemoteDataSource = MatchesRemoteDataSourceImpl(
//     dioWrapper: dioWrapper,
//   );

//   setUpAll(() {
//     registerFallbackValue(_FakeHttpRequestUriPartsValue());
//   });

//   tearDown(() {
//     reset(dioWrapper);
//   });

//   group(
//     "MatchesRemoteDataSource",
//     () {
//       group(
//         ".createMatch()",
//         () {
//           test(
//             "given valid $MatchCreateDataValue argument is passed "
//             "when call '.createMatch()'"
//             "then should return expected match id",
//             () async {
//               const matchId = 1;
//               // TODO in this group can possibly unify this - for specific
//               when(
//                 () => dioWrapper.post<Map<String, dynamic>>(
//                   uriParts: any(named: "uriParts"),
//                   bodyData: any(named: "bodyData"),
//                 ),
//               ).thenAnswer(
//                 (_) async {
//                   return {
//                     "ok": true,
//                     "data": matchId,
//                   };
//                 },
//               );

//               // Given
//               final createMatchValue = getTestMatchCreateValues(count: 1).first;

//               // When
//               final id = await matchesRemoteDataSource.createMatch(
//                 matchData: createMatchValue,
//               );

//               // Then
//               expect(id, equals(matchId));
//             },
//           );

//           test(
//             "given valid MatchCreateDataValue argument is passed "
//             "when call '.createMatch()'"
//             "then should call dioWrapper with expected arguments",
//             () async {
//               const matchId = 1;
//               // TODO in this group can possibly unify this - for specific
//               when(
//                 () => dioWrapper.post<Map<String, dynamic>>(
//                   uriParts: any(named: "uriParts"),
//                   bodyData: any(named: "bodyData"),
//                 ),
//               ).thenAnswer(
//                 (_) async {
//                   return {
//                     "ok": true,
//                     "data": matchId,
//                   };
//                 },
//               );

//               // Given
//               final createMatchValue = getTestMatchCreateValues(count: 1).first;

//               // When
//               await matchesRemoteDataSource.createMatch(
//                 matchData: createMatchValue,
//               );

//               final expectedUriParts = HttpRequestUriPartsValue(
//                 apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
//                 // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
//                 apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
//                 apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
//                 apiEndpointPath: HttpMatchesConstants
//                     .BACKEND_ENDPOINT_PATH_MATCH_CREATE.value,
//                 queryParameters: null,
//               );
//               final expectedBodyData = createMatchValue.toJson();

//               // Then
//               verify(
//                 () => dioWrapper.post<Map<String, dynamic>>(
//                   uriParts: expectedUriParts,
//                   bodyData: expectedBodyData,
//                 ),
//               ).called(1);
//             },
//           );
//         },
//       );
//       group(
//         ".getMatch()",
//         () {
//           test(
//             "given a match id"
//             "when call '.getMatch()'"
//             "then should return expected match",
//             () async {
//               final testMatch = getTestMatchRemoteEntities().first;
//               final testMatchJson = testMatch.toJson();
//               final matchResponse = {
//                 "ok": true,
//                 "data": testMatchJson,
//               };

//               when(
//                 () => dioWrapper.get<Map<String, dynamic>>(
//                   uriParts: any(named: "uriParts"),
//                 ),
//               ).thenAnswer((invocation) async => matchResponse);

//               final match = await matchesRemoteDataSource.getMatch(
//                 matchId: testMatch.id,
//               );

//               expect(match, equals(testMatch));
//             },
//           );

//           test(
//             "given a match request"
//             "when call '.getMatch()'"
//             "then should call dioWrapper with expected arguments",
//             () async {
//               final testMatch = getTestMatchRemoteEntities().first;
//               final testMatchJson = testMatch.toJson();
//               final matchResponse = {
//                 "ok": true,
//                 "data": testMatchJson,
//               };

//               final matchId = testMatch.id;

//               when(
//                 () => dioWrapper.get<Map<String, dynamic>>(
//                   uriParts: any(named: "uriParts"),
//                 ),
//               ).thenAnswer((invocation) async => matchResponse);

//               final expectedUriPartsArgs = HttpRequestUriPartsValue(
//                 // TODO use https when we have real server eventually
//                 apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
//                 // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
//                 apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
//                 apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
//                 apiEndpointPath: HttpMatchesConstants
//                     .BACKEND_ENDPOINT_PATH_MATCH
//                     .getMatchPathWithId(matchId),
//                 queryParameters: null,
//               );

//               await matchesRemoteDataSource.getMatch(
//                 matchId: testMatch.id,
//               );

//               verify(
//                 () => dioWrapper.get<Map<String, dynamic>>(
//                   uriParts: expectedUriPartsArgs,
//                 ),
//               );
//             },
//           );
//         },
//       );
//       group(
//         // TODO rename this to loadMyFollowingMatches
//         ".getMyFollowingMatches()",
//         () {
//           test(
//             "given nothing in particular"
//             "when '.getMyFollowingMatches() is called"
//             "should return expected list of matches",
//             () async {
//               final testMatches = getTestMatchRemoteEntities(count: 1);

//               final testMatchesJson =
//                   testMatches.map((match) => match.toJson()).toList();
//               final matchesResponse = {
//                 "ok": true,
//                 "data": testMatchesJson,
//               };

//               when(
//                 () => dioWrapper.get<Map<String, dynamic>>(
//                   uriParts: any(named: "uriParts"),
//                 ),
//               ).thenAnswer(
//                 (_) async {
//                   return matchesResponse;
//                 },
//               );

//               // TODO we should also test that correct arguments are used

//               final matches =
//                   await matchesRemoteDataSource.getPlayerInitialMatches();

//               expect(matches, equals(testMatches));
//             },
//           );
//         },

//         // TODO test interceptor that adds auth header - but this is is a different test - and later we can use that to get my matches, and not manually pass user idÞ
//       );
//     },
//   );
// }

// class _MockDioWrapper extends Mock implements DioWrapper {}

// class _FakeHttpRequestUriPartsValue extends Fake
//     implements HttpRequestUriPartsValue {}

// // TODO just temp until we go to real server
// List<MatchRemoteEntity> _generateTempManipulatedMatches(
//     List<MatchRemoteEntity> matchesEntities) {
//   final manipulatedMatchesToSplitBetweenTodayAndTomorrow = matchesEntities.map(
//     (match) {
//       final matchesLength = matchesEntities.length;
//       final isInFirstHalf = matchesEntities.indexOf(match) < matchesLength / 2;

//       final manipulatedDate = isInFirstHalf
//           ? DateTime.now().millisecondsSinceEpoch
//           : DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;

//       final manipulatedMatch = MatchRemoteEntity(
//         id: match.id,
//         date: manipulatedDate,
//         arrivingPlayers: match.arrivingPlayers,
//         description: match.description,
//         location: match.location,
//         name: match.name,
//         organizer: match.organizer,
//       );

//       return manipulatedMatch;
//     },
//   ).toList();

//   return manipulatedMatchesToSplitBetweenTodayAndTomorrow;
// }
