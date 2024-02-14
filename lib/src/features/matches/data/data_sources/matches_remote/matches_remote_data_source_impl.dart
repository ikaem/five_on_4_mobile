import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/constants/http_matches_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  MatchesRemoteDataSourceImpl({
    required DioWrapper dioWrapper,
  }) : _dioWrapper = dioWrapper;

  final DioWrapper _dioWrapper;

  // TODO this might not even be needed - we might have some endpoint like getInitialData, which would get all today, following matches, and stuff like that, maybe the whole home thing
  @override
  Future<List<MatchRemoteEntity>> getPlayerInitialMatches() async {
    final uriParts = HttpRequestUriPartsValue(
      // TODO use https when we have real server eventually
      apiUrlScheme: HttpConstants.HTTP_PROTOCOL.value,
      port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL_FAKE.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH_FAKE.value,
      apiEndpointPath:
          HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCHES_FAKE.value,
      queryParameters: null,
    );

    final response = await _dioWrapper.get<Map<String, dynamic>>(
      uriParts: uriParts,
    );

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

    // TODO temp only until real matches
    final manipulatedMatches = _generateTempManipulatedMatches(matchesEntities);

    return manipulatedMatches;
  }

  @override
  Future<MatchRemoteEntity> getMatch({
    required int matchId,
  }) async {
    final uriParts = HttpRequestUriPartsValue(
      // TODO use https when we have real server eventually
      apiUrlScheme: HttpConstants.HTTP_PROTOCOL.value,
      port: HttpConstants.BACKEND_PORT_STRING_FAKE.portAsInt,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL_FAKE.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH_FAKE.value,
      apiEndpointPath:
          HttpMatchesConstants.BACKEND_ENDPOINT_PATH_MATCHES_FAKE.value,
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
    return matchesEntities;

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
