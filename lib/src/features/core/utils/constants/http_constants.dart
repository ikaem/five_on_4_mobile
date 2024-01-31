enum HttpConstants {
  HTTPS_PROTOCOL('https'),
  HTTP_PROTOCOL('http'),

  // backend url
  BACKEND_BASE_URL_FAKE('localhost'),
  BACKEND_CONTEXT_PATH_FAKE(''),
  BACKEND_PORT_STRING_FAKE("3000");

  const HttpConstants(this.value);

  final String value;
}

extension HttpConstantsExtension on HttpConstants {
  int? get portAsInt =>
      int.tryParse(HttpConstants.BACKEND_PORT_STRING_FAKE.value);
}
