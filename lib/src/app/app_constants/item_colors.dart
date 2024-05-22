import 'dart:math';

import 'package:flutter/material.dart';

/// {@template itemColors.enum}
/// The base class for all failed operations
/// {@endtemplate}
enum ItemColors {
  ///{@macro itemColors.enum}
  green(Colors.greenAccent),

  ///{@macro itemColors.enum}
  blue(Colors.blueAccent),

  ///{@macro itemColors.enum}
  amber(Colors.lime);

  const ItemColors(this.color);

  ///{@macro itemColors.enum}
  final Color color;

  /// find correct color by hex value, stored in database
  static ItemColors getColorByHex(int hex) {
    return ItemColors.values.firstWhere(
      (e) => e.color.value == hex,
      orElse: getRandom,
    );
  }

  /// create random color
  static ItemColors getRandom() {
    final randomIndex = Random().nextInt(ItemColors.values.length);
    final color = ItemColors.values[randomIndex];
    return color;
  }
}
