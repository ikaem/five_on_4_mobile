import 'package:five_on_4_mobile/src/features/core/domain/values/http_request_value.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source_impl.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  // TODO we will try not to expose it via riverpod
  final dioWrapper = _MockDioWrapper();
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
        ".getMyFollowingMatches()",
        () {
          test(
            "given my userId"
            "when '.getMyFollowingMatches() is called"
            "should return expected list of matches",
            () async {
              final testMatches = getTestPlayerRemoteEntities();

              when(
                () => dioWrapper.get(
                  uriParts: any(
                      named: "uriParts",
                      // TODO this is cool - this is matcher
                      that: isA<HttpRequestUriPartsValue>()),
                ),
              ).thenAnswer(
                (_) async => testMatches,
              );

              final matches =
                  await matchesRemoteDataSource.getMyFollowingMatches();

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
