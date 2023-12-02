import 'dart:math';

abstract class Utils {
  const Utils._();

  static double generateCocktailDuration() => Random().nextInt(5) + 2;
  static double generateHourglassDuration() => generateCocktailDuration();
}
