import 'package:flutter/material.dart';

enum ColorConstants {
  // white
  WHITE._(Color(0xFFFFFFFF)),
  // black
  BLACK._(Color(0xFF4A4C4D)),

  // blue
  BLUE_LIGHT._(Color(0xFFDCF1FF)),
  BLUE_DARK._(Color(0xFF3F85D2)),

  // orange
  ORANGE._(Color(0xFFFB9B2E));

  const ColorConstants._(this.value);

  final Color value;
}
