enum RoutePathsConstants {
  // AUTHENTICATED ROUTES

  // shell routes
  ROOT("/"),
  SEARCH("/search"),
  SETTINGS("/settings"),

  // shell nested routes
  // TODO how to pass params
  MATCH("match"),
  MATCH_CREATE("create-match"),

  // non-shell routes
  LOADING("/loading"),
  ERROR("/error"),

  // NON AUTHENTICATED ROUTES
  LOGIN("/login");

  const RoutePathsConstants(this.value);
  final String value;
}
