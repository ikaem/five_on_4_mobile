enum HttpMatchesConstants {
  BACKEND_ENDPOINT_PATH_MATCHES._('matches'),
  BACKEND_ENDPOINT_PATH_MATCH._('matches/:id'),
  BACKEND_ENDPOINT_PATH_MATCH_CREATE._('matches'),
  BACKEND_ENDPOINT_PATH_MATCHES_PLAYER_MATCHES_OVERVIEW._(
      'matches/player-matches-overview'),
  // TODO rename the below one to
  // BACKEND_ENDPOINT_PATH_MATCHES_SEARCH._('matches/search');

  BACKEND_ENDPOINT_PATH_MATCHES_SEARCH_MATCHES._('matches/search');

  const HttpMatchesConstants._(this.value);
  final String value;
}

// rename to HttpMatchesConstantsExtension
extension HttpMatchesExtension on HttpMatchesConstants {
  String getMatchPathWithId(int id) {
    return value.replaceAll(':id', id.toString());
  }
}
