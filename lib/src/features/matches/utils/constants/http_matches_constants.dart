enum HttpMatchesConstants {
  BACKEND_ENDPOINT_PATH_MATCHES_FAKE('matches'),
  BACKEND_ENDPOINT_PATH_MATCH('match/:id');

  const HttpMatchesConstants(this.value);
  final String value;
}

extension HttpMatchesExtension on HttpMatchesConstants {
  String getMatchPathWithId(int id) {
    return value.replaceAll('/:id', "");
    // TODO this is for prod latr when we have real server
    // return value.replaceAll(':id', id.toString());
  }
}
