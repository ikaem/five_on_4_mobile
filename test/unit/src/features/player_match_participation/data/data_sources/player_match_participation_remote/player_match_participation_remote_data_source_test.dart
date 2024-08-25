import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_remote/player_match_participation_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_remote/player_match_participation_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/utils/constants/http_player_match_participations_constants.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_remote/players_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final dioWrapper = _MockDioWrapper();

  // tested class
  final dataSource =
      PlayerMatchParticipationRemoteDataSourceImpl(dioWrapper: dioWrapper);

  setUpAll(
    () {
      registerFallbackValue(_FakeHttpRequestUriPartsValue());
      registerFallbackValue(HttpMethodConstants.GET);
    },
  );

  tearDown(
    () {
      reset(dioWrapper);
    },
  );

  group(
    "$PlayerMatchParticipationRemoteDataSource",
    () {
      group(
        ".joinMatch()",
        () {
          final okResponseValue = HttpResponseValue(
            payload: {
              "ok": true,
              "message": "Player match participation stored successfully.",
              "data": {
                "id": 1,
              },
            },
          );
          test(
            "given ok response from [DioWrapper], "
            "when [.joinMatch()] is called, "
            "then should return expected response",
            () async {
              // setup

              // given
              when(
                () => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                  method: any(named: "method"),
                ),
              ).thenAnswer(
                (_) async {
                  return okResponseValue;
                },
              );

              // when
              final result = await dataSource.joinMatch(
                matchId: 1,
                playerId: 1,
              );

              // then
              expect(result, equals(1));

              // cleanup
            },
          );

          test(
            "given [.joinMatch()] is called, "
            "when examine request to the server"
            "then should have called [DioWrapper.makeRequest()] with expected arguments",
            () async {
              // setup
              when(
                () => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: any(named: "uriParts"),
                  method: any(named: "method"),
                ),
              ).thenAnswer(
                (_) async {
                  return okResponseValue;
                },
              );

              // given
              await dataSource.joinMatch(
                matchId: 1,
                playerId: 1,
              );

              // when / then
              final HttpRequestUriPartsValue expectedUriParts =
                  HttpRequestUriPartsValue(
                apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
                apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
                apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
                apiEndpointPath: HttpPlayerMatchParticipationsConstants
                    .BACKEND_ENDPOINT_PATH_PLAYER_MATCH_PARTICIPATION_STORE,
                queryParameters: const {
                  "match_id": "1",
                  "player_id": "1",
                },
              );
              const expectedMethod = HttpMethodConstants.POST;

              verify(
                () => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: expectedUriParts,
                  method: expectedMethod,
                ),
              ).called(1);

              // cleanup
            },
          );

          // TODO will need test for error as well
        },
      );
    },
  );
}

class _MockDioWrapper extends Mock implements DioWrapper {}

class _FakeHttpRequestUriPartsValue extends Fake
    implements HttpRequestUriPartsValue {}
