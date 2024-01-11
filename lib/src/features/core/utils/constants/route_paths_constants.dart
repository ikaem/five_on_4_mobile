enum RoutePathsConstants {
  // AUTHENTICATED ROUTES
  ROOT("/"),

  // SHELL ROUTES -> also authenticated
  SEARCH("/search"),
  SETTINGS("/settings"),
  // NON AUTHENTICATED ROUTES
  LOGIN("/login");

  const RoutePathsConstants(this.value);
  final String value;
}
