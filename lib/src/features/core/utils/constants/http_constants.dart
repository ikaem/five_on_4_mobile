enum HttpConstants {
  HTTPS_PROTOCOL('https'),
  HTTP_PROTOCOL('http'),

  // backend url
  // TODO only for emulators
  // BACKEND_BASE_URL_FAKE('10.0.2.2'),
  BACKEND_BASE_URL_FAKE('localhost'),
  BACKEND_CONTEXT_PATH_FAKE('api'),
  BACKEND_PORT_STRING_FAKE("4000");

  const HttpConstants(this.value);

  final String value;
}

extension HttpConstantsExtension on HttpConstants {
  int? get portAsInt =>
      int.tryParse(HttpConstants.BACKEND_PORT_STRING_FAKE.value);
}
