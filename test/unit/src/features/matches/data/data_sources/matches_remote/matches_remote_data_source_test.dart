import 'package:flutter_test/flutter_test.dart';

void main() {
  // TODO we will try not to expose it via riverpod

  final matchesRemoteDataSource = MatchesRemoteDataSourceImpl();

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
              // write the test
              const userId = "userId";
              final testMatches = getTestMatchesEntities();

              final matches =
                  await matchesRemoteDataSource.getMyFollowingMatches(
                userId: userId,
              );

              expect(matches, equals());
            },
          );
        },
      );
    },
  );
}
