import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_remote/players_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/utils/constants/http_players_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';

class PlayersRemoteDataSourceImpl implements PlayersRemoteDataSource {
  PlayersRemoteDataSourceImpl({
    required DioWrapper dioWrapper,
  }) : _dioWrapper = dioWrapper;

  final DioWrapper _dioWrapper;

  @override
  Future<List<PlayerRemoteEntity>> getSearchedPlayers({
    required SearchPlayersFilterValue searchPlayersFilter,
  }) async {
    final queryParams = {
      // TODO make these into constants
      // TODO make some kind of generator for query params based on arguemnts passed to it
      "name_term": searchPlayersFilter.name,
    };

    final HttpRequestUriPartsValue uriParts = HttpRequestUriPartsValue(
      apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
      apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
      apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
      apiEndpointPath:
          HttpPlayersConstants.BACKEND_ENDPOINT_PATH_PLAYERS_SEARCH.value,
      queryParameters: queryParams,
    );

    final response = await _dioWrapper.makeRequest<Map<String, dynamic>>(
      uriParts: uriParts,
      method: HttpMethodConstants.GET,
    );

    if (!response.isOk) {
      // TODO come back to this - this is to be tested later
      // TODO make proper exceptions for these things - already thowin simple exception in seach matches - ficx it
      throw Exception("Something went wrong with getting searched players.");
    }

    // TODO this seems flaky - make it better
    final responseJsonPlayersData =
        response.payload["data"]["players"] as List<dynamic>;

    final playersEntities = responseJsonPlayersData
        .map((e) => PlayerRemoteEntity.fromJson(json: e))
        .toList();

    return playersEntities;
  }
}
