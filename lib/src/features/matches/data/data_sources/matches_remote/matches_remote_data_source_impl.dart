import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/constants/http_matches_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  MatchesRemoteDataSourceImpl({
    required DioWrapper dioWrapper,
  }) : _dioWrapper = dioWrapper;

  final DioWrapper _dioWrapper;

  @override
  Future<int> createMatch({
    required MatchCreateDataValue matchData,
  }) async {
    throw UnimplementedError();
    // TODO come back to this
    // TODO constants are temp only
    // final uriParts = HttpRequestUriPartsValue(
    //   // TODO use https when we have real server eventually
    //   apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
    //   // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
    //   apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
    //   apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
    //   apiEndpointPath:
    //       HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH_CREATE.value,
    //   queryParameters: null,
    // );
    // final bodyData = matchData.toJson();

    // final response = await _dioWrapper.post<Map<String, dynamic>>(
    //   uriParts: uriParts,
    //   bodyData: matchData.toJson(),
    // );

    // // TODO wait for backend for this
    // if (response["ok"] != true) {
    //   throw Exception("Something went wrong with creating match");
    // }

    // final matchId = response["data"] as int;
    // return matchId;
  }

  @override
  Future<List<MatchRemoteEntity>> getPlayerMatchesOverview({
    required int playerId,
  }) async {
    final uriParts = HttpRequestUriPartsValue(
      // TODO use https when we have real server eventually
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpMatchesConstants
          .BACKEND_ENDPOINT_PATH_MATCHES_PLAYER_MATCHES_OVERVIEW.value,
      queryParameters: null,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
        uriParts: uriParts,
        method: HttpMethodConstants.GET,
        bodyData: {
          // TODO make constant for this
          "player_id": playerId,
        });

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      throw Exception(
          "Something went wrong with getting player matches overview");
    }

    // TODO maybe map string dynamic is better
    // TODO this looks flaky - but maybe it is fine
    final responseJsonMapMatches =
        response.payload["data"]["matches"] as List<Map<String, Object>>;

    final matchesOverview = responseJsonMapMatches
        .map((e) => MatchRemoteEntity.fromJson(json: e))
        .toList();

    return matchesOverview;

    // TODO: implement getPlayerMatchesOverview
    // throw UnimplementedError();
  }

  // TODO this might not even be needed - we might have some endpoint like getInitialData, which would get all today, following matches, and stuff like that, maybe the whole home thing
  // TODO remove this
  @override
  Future<List<MatchRemoteEntity>> getPlayerInitialMatches() async {
    throw UnimplementedError();
    // TODO come back to this
    // final uriParts = HttpRequestUriPartsValue(
    //   // TODO use https when we have real server eventually
    //   apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
    //   // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
    //   apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
    //   apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
    //   apiEndpointPath: HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCHES.value,
    //   queryParameters: null,
    // );

    // final response = await _dioWrapper.get<Map<String, dynamic>>(
    //   uriParts: uriParts,
    // );

    // // TODO make extension or class out of the responseBody or responseData or something
    // if (response["ok"] != true) {
    //   throw Exception("Something went wrong with getting matches");
    // }
    // // TODO this should be typed better I guess
    // final matchesJson =
    //     (response["data"] as List<dynamic>).cast<Map<String, dynamic>>();

    // final matchesEntities = matchesJson
    //     .map(
    //       (matchJson) => MatchRemoteEntity.fromJson(json: matchJson),
    //     )
    //     .toList();

    // return matchesEntities;
  }

  @override
  Future<MatchRemoteEntity> getMatch({
    required int matchId,
  }) async {
    throw UnimplementedError();

    // // TODO temp only
    // // await Future.delayed(const Duration(seconds: 1));
    // final uriParts = HttpRequestUriPartsValue(
    //   // TODO use https when we have real server eventually
    //   apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
    //   // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,S
    //   apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
    //   apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
    //   apiEndpointPath: HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH
    //       .getMatchPathWithId(matchId),
    //   queryParameters: null,
    // );

    // final response = await _dioWrapper.get<Map<String, dynamic>>(
    //   uriParts: uriParts,
    // );

    // if (response["ok"] != true) {
    //   throw Exception("Something went wrong with getting match");
    // }

    // final matchJson = response["data"] as Map<String, dynamic>;

    // final matchEntity = MatchRemoteEntity.fromJson(json: matchJson);

    // return matchEntity;
  }

  List<MatchRemoteEntity> _generateTempManipulatedMatches(
    List<MatchRemoteEntity> matchesEntities,
  ) {
    throw UnimplementedError();

// // TODO temp
//     // return matchesEntities;

//     final manipulatedMatchesToSplitBetweenTodayAndTomorrow =
//         matchesEntities.map(
//       (match) {
//         final matchesLength = matchesEntities.length;
//         final isInFirstHalf =
//             matchesEntities.indexOf(match) < matchesLength / 2;

//         final manipulatedDate = isInFirstHalf
//             ? DateTime.now().millisecondsSinceEpoch
//             : DateTime.now()
//                 .add(const Duration(days: 1))
//                 .millisecondsSinceEpoch;

//         final manipulatedMatch = MatchRemoteEntity(
//           id: match.id,
//           date: manipulatedDate,
//           arrivingPlayers: match.arrivingPlayers,
//           description: match.description,
//           location: match.location,
//           name: match.name,
//           organizer: match.organizer,
//         );

//         return manipulatedMatch;
//       },
//     ).toList();

//     return manipulatedMatchesToSplitBetweenTodayAndTomorrow;
  }
}
