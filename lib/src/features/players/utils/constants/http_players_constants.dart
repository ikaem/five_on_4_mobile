enum HttpPlayersConstants {
  BACKEND_ENDPOINT_PATH_PLAYERS._('players'),
  BACKEND_ENDPOINT_PATH_PLAYER._('players/:id'),
  BACKEND_ENDPOINT_PATH_PLAYERS_SEARCH._('players/search');

  const HttpPlayersConstants._(this.value);
  final String value;
}

extension HttpPlayersConstantsExtension on HttpPlayersConstants {
  String getPlayerPathWithId(int id) {
    return value.replaceAll(':id', id.toString());
  }
}
