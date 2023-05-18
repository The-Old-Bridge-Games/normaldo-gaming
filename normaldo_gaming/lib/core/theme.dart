import 'package:flutter/material.dart';

abstract class NGTheme {
  const NGTheme._();

  static final green1 = Colors.green[800]!;

  static const displayLarge = TextStyle(
    fontSize: 24,
    color: Colors.white,
  );

  static const displayMedium = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
}
