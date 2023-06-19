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
  trashBin,
  pizza,
  dollar,
  fatPizza,
  dumbbell,
  moneyBag,
  bomb,
  cocktail,
  molotov;
  // trashBin(0, 1),
  // pizza(250, 0),
  // dollar(0, 0),
  // fatPizza(250, 0),
  // dumbbell(0, 3),
  // moneyBag(0, 0),
  // bomb(0, 5),
  // cocktail(0, 10),
  // molotov(500, 0); // 15 startLevel

  PositionComponent component() {
    switch (this) {
      case Items.trashBin:
        return TrashBin();
      case Items.pizza:
        return Pizza();
      case Items.dollar:
        return Dollar();
      case Items.fatPizza:
        return FatPizza();
      case Items.dumbbell:
        return Dumbbell();
      case Items.moneyBag:
        return MoneyBag();
      case Items.bomb:
        return Bomb();
      case Items.cocktail:
        return Cocktail();
      case Items.molotov:
        return Molotov();
    }
  }
}
