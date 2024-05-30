enum SecureStorageAuthKeyConstants {
  // ACCESS_COOKIE("FIVE_ON_4_AUTH_COOKIE"),
  // // TODO this might go away
  // // TOKEN("FIVE_ON_4_AUTH_TOKEN"),
  // // TODO not sure if i should use auth id
  // // TODO but if it is auth id, not sure
  // AUTH_ID("FIVE_ON_4_AUTH_ID");
  ACCESS_TOKEN("five_on_4_access_token"),
  REFRESH_TOKEN_COOKIE("five_on_4_refresh_token_cookie");

  const SecureStorageAuthKeyConstants(this.value);
  final String value;
}
