import 'dart:math';

abstract class Utils {
  const Utils._();

  static const bigBuddyBinSpeedMultiplier = 1.5;

  static double generateCocktailDuration() => Random().nextInt(5) + 2;
  static double generateHourglassDuration() => generateCocktailDuration();
}
