import 'package:flutter/material.dart';

enum ItemColors {
  Green(Colors.greenAccent),
  Blue(Colors.blueAccent),
  Amber(Colors.lime);

  const ItemColors(this.color);
  final Color color;
}
