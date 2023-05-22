import 'package:flutter/material.dart';

abstract class NGTheme {
  const NGTheme._();

  static const _fontFamily = 'HyperStiffRoundBootiedOpossumRegular';

  static final green1 = Colors.green[800]!;

  static const displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    color: Colors.white,
  );

  static const displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    color: Colors.white,
  );

  static const displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    color: Colors.white,
  );

  static const bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    color: Colors.white,
  );
}
