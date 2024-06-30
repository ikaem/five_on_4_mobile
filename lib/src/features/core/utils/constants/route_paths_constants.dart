enum RoutePathsConstants {
  ROOT("/"),
  // AUTHENTICATED ROUTES

  // shell routes
  HOME("home"),
  SEARCH("search"),
  SETTINGS("settings"),

  // shell nested routes
  // TODO how to pass params
  MATCH("match"),
  MATCH_CREATE("create-match"),

  // non-shell routes
  LOADING("/loading"),
  ERROR("/error"),

  // NON AUTHENTICATED ROUTES - note they have "/" becasue they are not nested in the shell
  // LOGIN("/login"),
  // REGISTER("/register");
  LOGIN("login"),
  REGISTER("register");

  const RoutePathsConstants(this.value);
  final String value;
}

// TODO test for now - make it more elegant too, or add this extension on route constants or something
extension RouteStringValueExtension on String {
  String get withRouteSlashPrefix => "/$this";
}
