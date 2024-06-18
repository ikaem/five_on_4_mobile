import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/converters/authenticated_player_converters.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "$AuthenticatedPlayerConverters",
    () {
      test(
        "given an AuthenticatedPlayerLocalEntityData"
        "when .toModelFromLocalEntityData() is called"
        "then should return expected AuthenticatedPlayerModel",
        () async {
          // setup

          // given
          const entityData = AuthenticatedPlayerLocalEntityData(
            playerId: 1,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );

          // when
          final result =
              AuthenticatedPlayerConverters.toModelFromLocalEntityData(
            entity: entityData,
          );

          // then
          const model = AuthenticatedPlayerModel(
            playerId: 1,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );
          expect(
              result,
              equals(
                model,
              ));

          // cleanup
        },
      );
    },
  );
}
