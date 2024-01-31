enum HttpConstants {
  HTTPS_PROTOCOL('https'),
  HTTP_PROTOCOL('http'),

  // backend url
  BACKEND_BASE_URL_FAKE('localhost:3000'),
  BACKEND_CONTEXT_PATH_FAKE('');

  const HttpConstants(this.value);

  final String value;
}
