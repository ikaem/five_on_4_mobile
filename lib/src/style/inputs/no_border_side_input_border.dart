import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// An [OutlineInputBorder] that keeps input label inside the input
///
/// Based on https://stackoverflow.com/a/77964959/9661910
class InsideLabeledOutlineInputBorder extends OutlineInputBorder {
  const InsideLabeledOutlineInputBorder({
    super.borderSide = const BorderSide(),
    super.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    super.gapPadding = 0,
  });

  @override
  bool get isOutline => false;

  factory InsideLabeledOutlineInputBorder.topRounded({
    double borderRadiusValue = 10,
  }) {
    return InsideLabeledOutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(borderRadiusValue),
        bottom: const Radius.circular(0),
      ),
    );
  }

  factory InsideLabeledOutlineInputBorder.bottomRounded({
    double borderRadiusValue = 10,
  }) {
    return InsideLabeledOutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.vertical(
        top: const Radius.circular(0),
        bottom: Radius.circular(borderRadiusValue),
      ),
    );
  }
}
