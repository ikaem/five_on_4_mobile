enum RoutePathsConstants {
  // AUTH ROUTES
  ROOT("/"),

  // NON AUTH ROUTES
  LOGIN("/login");

  const RoutePathsConstants(this.value);
  final String value;
}
