import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bomb.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/cocktail.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dumbbell.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/fat_pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/molotov.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/money_bag.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 1000 (or refactor it)
  trashBin(566, 0),
  pizza(326, 0),
  dollar(44, 0),
  fatPizza(4, 3),
  dumbbell(8, 1),
  moneyBag(2, 2),
  bomb(10, 5),
  cocktail(20, 5),
  molotov(20, 10);
  // trashBin(0, 1),
  // pizza(250, 0),
  // dollar(0, 0),
  // fatPizza(250, 0),
  // dumbbell(0, 3),
  // moneyBag(0, 0),
  // bomb(0, 5),
  // cocktail(0, 10),
  // molotov(500, 0); // 15 startLevel

  const Items(this.chance, this.startLevel);

  final int chance;
  final int startLevel;

  PositionComponent component({required GameSessionCubit cubit}) {
    switch (this) {
      case Items.trashBin:
        return TrashBin(cubit: cubit);
      case Items.pizza:
        return Pizza(cubit: cubit);
      case Items.dollar:
        return Dollar(cubit: cubit);
      case Items.fatPizza:
        return FatPizza(cubit: cubit);
      case Items.dumbbell:
        return Dumbbell(cubit: cubit);
      case Items.moneyBag:
        return MoneyBag(cubit: cubit);
      case Items.bomb:
        return Bomb(cubit: cubit);
      case Items.cocktail:
        return Cocktail(cubit: cubit);
      case Items.molotov:
        return Molotov(cubit: cubit);
    }
  }
}
