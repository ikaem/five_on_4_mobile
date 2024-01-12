import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';

final testAuthDataEntity = AuthDataEntity(
  playerInfo: AuthDataPlayerInfoEntity(
    id: 1,
    firstName: "John",
    lastName: "Doe",
    nickName: "JD",
  ),
  teamInfo: AuthDataTeamInfoEntity(
    id: 1,
    teamName: "Team 1",
  ),
);
