import 'package:flutter/material.dart';

enum CircularRadiusConstants {
  EXTRA_SMALL._(Radius.circular(4)),
  SMALL._(Radius.circular(6)),
  REGULAR._(Radius.circular(10)),
  LARGE._(Radius.circular(14)),
  EXTRA_LARGE._(Radius.circular(16)),
  EXTRA_EXTRA_LARGE._(Radius.circular(20));

  const CircularRadiusConstants._(this.value);
  final Radius value;
}
