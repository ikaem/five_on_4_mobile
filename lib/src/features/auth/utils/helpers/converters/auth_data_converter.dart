import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';

abstract class AuthDataConverter {
  static toModelFromEntity({required AuthDataEntity entity}) {
    final model = AuthDataModel(
      playerId: entity.playerInfo.id!,
      fullName: '${entity.playerInfo.firstName} ${entity.playerInfo.lastName}',
      nickName: entity.playerInfo.nickName!,
      teamId: entity.teamInfo.id!,
      teamName: entity.teamInfo.teamName!,
    );

    return model;
  }
}
