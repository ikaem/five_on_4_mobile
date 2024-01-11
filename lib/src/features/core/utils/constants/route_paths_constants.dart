enum RoutePathsConstants {
  // AUTHENTICATED ROUTES

  // shell routes
  ROOT("/"),
  SEARCH("/search"),
  SETTINGS("/settings"),

  // non-shell routes
  // TODO how to pass params
  MATCH("match"),

  // NON AUTHENTICATED ROUTES
  LOGIN("/login");

  const RoutePathsConstants(this.value);
  final String value;
}
