import 'dart:developer';

import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/exceptions/match_exceptions.dart';
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
    final HttpRequestUriPartsValue uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH_CREATE.value,
      queryParameters: null,
    );

    final bodyData = {
      // TODO create constants for these
      "title": matchData.name,
      "location": matchData.location,
      // TODO not needed yet
      // "organizer": matchData.organizer,
      "description": matchData.description,
      // TODO not needed yet
      // "invitedPlayers": matchData.invitedPlayers,
      "dateAndTime": matchData.dateTime,
    };

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
      // bodyData: matchData.toJson(),
      bodyData: bodyData,
    );

    if (!response.isOk) {
      // throw Exception("Something went wrong with creating match");
      // TODO maybe more info should be passed here so that log works? I am not sure?
      // TODO do better logging here
      log("Something went wrong with creating match: ${response.message}");
      throw const MatchesExceptionMatchFailedToCreate();
    }

    // TODO need to do this better somehow - maybe pass key of stuff in data, and have a function to get it from there? - it would also cast it to the type - or throw error if invalid?
    final matchId = response.payload["data"]["matchId"] as int;

    return matchId;

    // throw UnimplementedError();
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
  Future<MatchRemoteEntity> getMatch({
    required int matchId,
  }) async {
    final HttpRequestUriPartsValue uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH
          .getMatchPathWithId(matchId),
      queryParameters: null,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.GET,
    );

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      // TODO make better exception for this
      // TODO log this
      throw Exception(
          "Something went wrong with getting match: ${response.message}");
    }

    final responseMatchJsonMap = response.payload["data"]["match"];
    final responseParticipationJsonMaps =
        response.payload["data"]["participations"];

    print("responseMatchJsonMap: $responseMatchJsonMap");

    final MatchRemoteEntity matchEntity = MatchRemoteEntity.fromJson(
      matchJsonMap: responseMatchJsonMap,
      participationJsonMaps: responseParticipationJsonMaps,
    );

    return matchEntity;
  }

  @override
  Future<List<MatchRemoteEntity>> getSearchedMatches(
      {required SearchMatchesFilterValue searchMatchesFilter}) async {
    // TODO: implement getSearchedMatches
    final HttpRequestUriPartsValue uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpMatchesConstants
          .BACKEND_ENDPOINT_PATH_MATCHES_SEARCH_MATCHES.value,
      // TODO eventually we will switch to query params, and not to body
      queryParameters: null,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
        uriParts: uriParts,
        // TODO post is not good for this - use get
        method: HttpMethodConstants.POST,
        bodyData: {
          // TODO create constants for these
          "match_title": searchMatchesFilter.matchTitle,
        });

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      // TODO make proper exception for this
      throw Exception("Something went wrong with getting searched matches");
    }

    final responseJsonMapMatchesData =
        response.payload["data"]["matches"] as List<dynamic>;

    final matchesEntities = responseJsonMapMatchesData
        .map((e) => MatchRemoteEntity.fromJson(
              matchJsonMap: e,
              // TODO no participations are needed or returned in searched matches - for now
              participationJsonMaps: const [],
            ))
        .toList();

    return matchesEntities;
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
    final responseJsonMapMatchesData =
        response.payload["data"]["matches"] as List<dynamic>;

    final matchesOverview = responseJsonMapMatchesData
        .map((e) => MatchRemoteEntity.fromJson(
              matchJsonMap: e,
              // TODO no participations are needed or returned in player matches overview - for now
              // TODO but it might be needed in future, to be able to immediately show what is current number of participating players and so on - future work
              participationJsonMaps: const [],
            ))
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
