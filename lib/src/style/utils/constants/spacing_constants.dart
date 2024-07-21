enum SpacingConstants {
  NONE._(0),
  XS._(5),
  S._(10),
  M._(15),

  /// 20px - Use for padding around screen edges
  L._(20),
  XL._(30),
  XXL._(40),
  XXXL._(50);

  const SpacingConstants._(this.value);
  final double value;
}
