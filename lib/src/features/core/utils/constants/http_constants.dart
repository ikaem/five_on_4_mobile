enum HttpConstants {
  HTTPS_PROTOCOL('https'),
  // HTTP_PROTOCOL('http'),

  // backend url
  // TODO only for emulators
  // BACKEND_BASE_URL_FAKE('10.0.2.2'),
  BACKEND_BASE_URL('five-on-4-api.onrender.com'),
  BACKEND_CONTEXT_PATH('api');
  // BACKEND_PORT_STRING_FAKE("4000");

  const HttpConstants(this.value);

  final String value;
}

// extension HttpConstantsExtension on HttpConstants {
//   int? get portAsInt =>
//       int.tryParse(HttpConstants.BACKEND_PORT_STRING_FAKE.value);
// }
