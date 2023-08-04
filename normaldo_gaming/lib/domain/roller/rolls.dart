enum Rolls {
  // Gives 1 exp
  exp1(20),
  // Gives 2 exp
  exp2(15),
  // Gives 3 exps
  exp3(5),
  // Reduces your bid by 2
  half1(27.75),
  // Shows different values on slot machine
  empty(27.75),
  // Gives extra life bonus to your user
  extraLife(3),
  // Gives x1.5 to your bid
  win(1),
  // Gives 10x to your bid
  jackpot(0.5);

  const Rolls(this.baseChance);

  final double baseChance;

  double weight(int rate) => switch (this) {
        exp1 => baseChance + (0.5 * rate),
        exp2 => baseChance + (0.25 * rate),
        exp3 => baseChance + (0.25 * rate),
        half1 => baseChance + (-0.69375 * rate),
        empty => baseChance + (-0.69375 * rate),
        extraLife => baseChance + (0.15 * rate),
        win => baseChance + (0.15 * rate),
        jackpot => baseChance + (0.0875 * rate),
      };

  @override
  String toString() {
    return switch (this) {
      exp1 => '1 опыт!',
      exp2 => '2 опыта!',
      exp3 => '3 опыта!',
      half1 => '1/2 ставки!',
      empty => 'Не повезло!',
      extraLife => 'Доп. жизнь!',
      win => '1.5х ставки!',
      jackpot => '5х ставки',
    };
  }
}
