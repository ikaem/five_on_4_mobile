enum HttpMatchesConstants {
  BACKEND_ENDPOINT_PATH_MATCHES('matches'),
  BACKEND_ENDPOINT_PATH_MATCH('matches/:id'),
  BACKEND_ENDPOINT_PATH_MATCH_CREATE_FAKE('matches');

  const HttpMatchesConstants(this.value);
  final String value;
}

extension HttpMatchesExtension on HttpMatchesConstants {
  String getMatchPathWithId(int id) {
    return value.replaceAll('/:id', id.toString());
  }
}
