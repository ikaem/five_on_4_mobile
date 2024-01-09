enum SecureStorageAuthKeyConstants {
  TOKEN("FIVE_ON_4_AUTH_TOKEN"),
  // TODO not sure if i should use auth id
  // TODO but if it is auth id, not sure
  AUTH_ID("FIVE_ON_4_AUTH_ID");

  const SecureStorageAuthKeyConstants(this.value);
  final String value;
}
