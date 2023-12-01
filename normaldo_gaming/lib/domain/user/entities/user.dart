final class User {
  final String id;
  final String name;
  final int highScore;
  final int dollars;
  final int level;
  final int exp;
  final int extraLives;
  final int totalPizzas;

  const User({
    required this.id,
    required this.name,
    required this.highScore,
    required this.dollars,
    required this.level,
    required this.exp,
    required this.extraLives,
    required this.totalPizzas,
  });
}
