import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/http_methods_constants.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_remote/players_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_remote/players_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_fluter_value.dart';
import 'package:five_on_4_mobile/src/features/players/utils/constants/http_players_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final dioWrapper = _MockDioWrapper();

  // tested class
  final dataSource = PlayersRemoteDataSourceImpl(dioWrapper: dioWrapper);

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
    "$PlayersRemoteDataSource",
    () {
      group(".getPlayer()", () {
        test(
          "given ok response from [DioWrapper], "
          "when [.getPlayer()] is called, "
          "then should return expected response",
          () async {
            // setup
            const playerEntity = PlayerRemoteEntity(
              id: 1,
              firstName: "John",
              lastName: "Doe",
              avatarUrl:
                  "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
              nickname: "JD",
            );

            // given
            when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                uriParts: any(named: "uriParts"),
                method: any(named: "method"))).thenAnswer((_) async {
              return HttpResponseValue(payload: {
                "ok": true,
                "message": "Player retrieved successfully.",
                "data": {
                  "player": {
                    "id": playerEntity.id,
                    "firstName": playerEntity.firstName,
                    "lastName": playerEntity.lastName,
                    "nickname": playerEntity.nickname,
                    "authId": playerEntity.id,
                  }
                }
              });
            });

            // when
            final player = await dataSource.getPlayer(id: 1);

            // then
            expect(player, equals(playerEntity));

            // cleanup
          },
        );

        test(
          "given [.getPlayer()] is called"
          "when examine request to the server"
          "then should have called [DioWrapper.makeRequest()] with expected arguments",
          () async {
            // setup

            // given
            when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                uriParts: any(named: "uriParts"),
                method: any(named: "method"))).thenAnswer((_) async {
              return HttpResponseValue(payload: {
                "ok": true,
                "message": "Player retrieved successfully.",
                "data": {
                  "player": {
                    "id": 1,
                    "firstName": "John",
                    "lastName": "Doe",
                    "nickname": "JD",
                    "authId": 1,
                  }
                }
              });
            });

            // when
            await dataSource.getPlayer(id: 1);

            // then
            final expectedUriParts = HttpRequestUriPartsValue(
              apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
              apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
              apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
              apiEndpointPath: HttpPlayersConstants.BACKEND_ENDPOINT_PATH_PLAYER
                  .getPlayerPathWithId(1),
              queryParameters: null,
            );
            const expectedMethod = HttpMethodConstants.GET;

            verify(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                  uriParts: expectedUriParts,
                  method: expectedMethod,
                ));

            // cleanup
          },
        );
      });
      group(
        ".getSearchedPlayers()",
        () {
          test(
            "given ok response from [DioWrapper], "
            "when [.getSearchedPlayers()] is called, "
            "then should return expected response",
            () async {
              // setup
              const SearchPlayersFilterValue filter = SearchPlayersFilterValue(
                name: "John",
              );

              final playerEntities = List.generate(
                  3,
                  (i) => PlayerRemoteEntity(
                        id: i + 1,
                        // name: "John Doe",
                        firstName: "John",
                        lastName: "Doe",
                        avatarUrl:
                            "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
                        nickname: "JD",
                      ));

              // given
              when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                    uriParts: any(named: "uriParts"),
                    method: any(named: "method"),
                  )).thenAnswer((_) async {
                return HttpResponseValue(
                  payload: {
                    "ok": true,
                    "message": "Players searched successfully.",
                    "data": {
                      "players": playerEntities
                          .map((e) => {
                                "id": e.id,
                                // "name": e.name,
                                "firstName": e.firstName,
                                "lastName": e.lastName,
                                // TODO this will be remove from backend response in future
                                "authId": e.id,
                                // TODO this is not available yet - come back to it
                                // "avatarUrl": e.avatarUrl,
                                "nickname": e.nickname,
                              })
                          .toList(),
                    }
                  },
                );
              });

              // when
              final players = await dataSource.getSearchedPlayers(
                searchPlayersFilter: filter,
              );

              // then
              expect(players, playerEntities);

              // cleanup
            },
          );

          test(
            "given [.getSearchedPlayers()] is called"
            "when examine request to the server"
            "then should call [DioWrapper.makeRequest()] with expected arguments",
            () async {
              // setup
              const SearchPlayersFilterValue filter = SearchPlayersFilterValue(
                name: "John",
              );
              when(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                    uriParts: any(named: "uriParts"),
                    method: any(named: "method"),
                  )).thenAnswer((_) async {
                return HttpResponseValue(
                  payload: {
                    "ok": true,
                    "message": "Players searched successfully.",
                    "data": {
                      "players": <Map<String, dynamic>>[],
                    }
                  },
                );
              });

              // given
              await dataSource.getSearchedPlayers(
                searchPlayersFilter: filter,
              );

              // when
              final capturedUriParts =
                  verify(() => dioWrapper.makeRequest<Map<String, dynamic>>(
                        uriParts: captureAny(named: "uriParts"),
                        method: captureAny(named: "method"),
                      )).captured;

              // then
              final HttpRequestUriPartsValue expectedUriParts =
                  HttpRequestUriPartsValue(
                apiUrlScheme: HttpConstants.HTTPS_PROTOCOL.value,
                apiBaseUrl: HttpConstants.BACKEND_BASE_URL.value,
                apiContextPath: HttpConstants.BACKEND_CONTEXT_PATH.value,
                apiEndpointPath: HttpPlayersConstants
                    .BACKEND_ENDPOINT_PATH_PLAYERS_SEARCH.value,
                queryParameters: {
                  "name_term": filter.name,
                },
              );
              const HttpMethodConstants expectedMethod =
                  HttpMethodConstants.GET;

              final actualUriParts =
                  capturedUriParts.first as HttpRequestUriPartsValue;
              final actualMethod = capturedUriParts.last as HttpMethodConstants;

              expect(actualUriParts, expectedUriParts);
              expect(actualMethod, expectedMethod);

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockDioWrapper extends Mock implements DioWrapper {}

class _FakeHttpRequestUriPartsValue extends Fake
    implements HttpRequestUriPartsValue {}
