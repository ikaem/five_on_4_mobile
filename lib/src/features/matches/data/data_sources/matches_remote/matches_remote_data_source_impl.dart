import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
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
    // TODO constants are temp only
    final uriParts = HttpRequestUriPartsValue(
      // TODO use https when we have real server eventually
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH_CREATE.value,
      queryParameters: null,
    );
    final bodyData = matchData.toJson();

    final response = await _dioWrapper.post<Map<String, dynamic>>(
      uriParts: uriParts,
      bodyData: matchData.toJson(),
    );

    // TODO wait for backend for this
    if (response["ok"] != true) {
      throw Exception("Something went wrong with creating match");
    }

    final matchId = response["data"] as int;
    return matchId;
  }

  // TODO this might not even be needed - we might have some endpoint like getInitialData, which would get all today, following matches, and stuff like that, maybe the whole home thing
  @override
  Future<List<MatchRemoteEntity>> getPlayerInitialMatches() async {
    final uriParts = HttpRequestUriPartsValue(
      // TODO use https when we have real server eventually
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCHES.value,
      queryParameters: null,
    );

    final response = await _dioWrapper.get<Map<String, dynamic>>(
      uriParts: uriParts,
    );

    // TODO make extension or class out of the responseBody or responseData or something
    if (response["ok"] != true) {
      throw Exception("Something went wrong with getting matches");
    }
    // TODO this should be typed better I guess
    final matchesJson =
        (response["data"] as List<dynamic>).cast<Map<String, dynamic>>();

    final matchesEntities = matchesJson
        .map(
          (matchJson) => MatchRemoteEntity.fromJson(json: matchJson),
        )
        .toList();

    return matchesEntities;
  }

  @override
  Future<MatchRemoteEntity> getMatch({
    required int matchId,
  }) async {
    // TODO temp only
    // await Future.delayed(const Duration(seconds: 1));
    final uriParts = HttpRequestUriPartsValue(
      // TODO use https when we have real server eventually
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      // port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,S
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCH
          .getMatchPathWithId(matchId),
      queryParameters: null,
    );

    final response = await _dioWrapper.get<Map<String, dynamic>>(
      uriParts: uriParts,
    );

    if (response["ok"] != true) {
      throw Exception("Something went wrong with getting match");
    }

    final matchJson = response["data"] as Map<String, dynamic>;

    final matchEntity = MatchRemoteEntity.fromJson(json: matchJson);

    return matchEntity;
  }

  List<MatchRemoteEntity> _generateTempManipulatedMatches(
      List<MatchRemoteEntity> matchesEntities) {
// TODO temp
    // return matchesEntities;

    final manipulatedMatchesToSplitBetweenTodayAndTomorrow =
        matchesEntities.map(
      (match) {
        final matchesLength = matchesEntities.length;
        final isInFirstHalf =
            matchesEntities.indexOf(match) < matchesLength / 2;

        final manipulatedDate = isInFirstHalf
            ? DateTime.now().millisecondsSinceEpoch
            : DateTime.now()
                .add(const Duration(days: 1))
                .millisecondsSinceEpoch;

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
}
