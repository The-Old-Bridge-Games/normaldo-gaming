import 'package:flutter/material.dart';

abstract class NGTheme {
  const NGTheme._();

  static const _fontFamily = 'NormaldoFont';

  static const green1 = Color(0xff22B14C);
  static const green2 = Color(0xffB5E61D);
  static const bgSemiBlack = Colors.black38;
  static const heartRed = Color(0xffDC0000);
  static const purple1 = Color(0xffA349A4);
  static const purple2 = Color(0xff7C347C);
  static const purple3 = Color(0xff5E265E);
  static const orange1 = Color(0xffFFCC00);

  static const auraGreen = green1;
  static const auraRed = Color(0xffDC0000);
  static const auraBlue = Color.fromARGB(255, 103, 179, 254);

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
    fontSize: 12,
    color: Colors.white,
  );
}
