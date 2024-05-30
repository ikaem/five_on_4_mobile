enum HttpAuthConstants {
  // TODO maybe change this
  // TODO will be adding slash before auth here -> /auth/google-auth
  BACKEND_ENDPOINT_PATH_AUTH_GOOGLE("auth/google-auth"),
  BACKEND_ENDPOINT_PATH_LOGOUT("/auth/logout"),
  BACKEND_ENDPOINT_PATH_GET_AUTH("/auth/get");

  const HttpAuthConstants(this.value);
  final String value;
}