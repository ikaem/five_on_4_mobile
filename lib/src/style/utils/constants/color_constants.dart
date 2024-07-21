import 'package:flutter/material.dart';

enum ColorConstants {
  // white
  WHITE._(Color(0xFFFFFFFF)),

  // blue
  BLUE_LIGHT._(Color(0xFFDCF1FF));

  const ColorConstants._(this.value);

  final Color value;
}
