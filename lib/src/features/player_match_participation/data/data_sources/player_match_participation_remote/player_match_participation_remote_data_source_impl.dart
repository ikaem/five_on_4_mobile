import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_remote/player_match_participation_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/utils/constants/http_player_match_participations_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';

class PlayerMatchParticipationRemoteDataSourceImpl
    implements PlayerMatchParticipationRemoteDataSource {
  PlayerMatchParticipationRemoteDataSourceImpl({
    required DioWrapper dioWrapper,
  }) : _dioWrapper = dioWrapper;

  final DioWrapper _dioWrapper;

  @override
  Future<int> joinMatch({
    required int matchId,
    required int playerId,
  }) async {
    final queryParams = <String, String>{
      // TODO make these into constants
      "match_id": matchId.toString(),
      "player_id": playerId.toString(),
      // TODO should take this from that enum for status
      "participation_status": "arriving",
    };

    final HttpRequestUriPartsValue uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpPlayerMatchParticipationsConstants
          .BACKEND_ENDPOINT_PATH_PLAYER_MATCH_PARTICIPATION_STORE,
      queryParameters: queryParams,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
    );

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      // TODO make proper exceptions for these things - already thowin simple exception in seach matches - ficx it
      throw Exception("Something went wrong with joining match.");
    }

    // TODO this seems flaky - make it better
    final responseJsonPlayerMatchParticipationData =
        response.payload["data"]["id"] as int;

    return responseJsonPlayerMatchParticipationData;
  }

  @override
  Future<int> unjoinMatch({required int matchId, required int playerId}) async {
    final queryParams = <String, String>{
      // TODO make these into constants
      "match_id": matchId.toString(),
      "player_id": playerId.toString(),
      // TODO should take this from that enum for status
      "participation_status": "notArriving",
    };

    final uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpPlayerMatchParticipationsConstants
          .BACKEND_ENDPOINT_PATH_PLAYER_MATCH_PARTICIPATION_STORE,
      queryParameters: queryParams,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
    );

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      // TODO make proper exceptions for these things - already thowin simple exception in seach matches - ficx it
      throw Exception("Something went wrong with unjoining match.");
    }

    // TODO this seems flaky - make it better
    final responseJsonPlayerMatchParticipationData =
        response.payload["data"]["id"] as int;

    return responseJsonPlayerMatchParticipationData;
  }

  @override
  Future<int> inviteToMatch(
      {required int matchId, required int playerId}) async {
    final queryParams = <String, String>{
      // TODO make these into constants
      "match_id": matchId.toString(),
      "player_id": playerId.toString(),
      // TODO should take this from that enum for status
      "participation_status": "pendingDecision",
    };

    final uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath: HttpPlayerMatchParticipationsConstants
          .BACKEND_ENDPOINT_PATH_PLAYER_MATCH_PARTICIPATION_STORE,
      queryParameters: queryParams,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.POST,
    );

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      // TODO make proper exceptions for these things - already thowin simple exception in seach matches - ficx it
      throw Exception("Something went wrong with inviting to match.");
    }

    // TODO this seems flaky - make it better
    final responseJsonPlayerMatchParticipationData =
        response.payload["data"]["id"] as int;

    return responseJsonPlayerMatchParticipationData;
  }
}
