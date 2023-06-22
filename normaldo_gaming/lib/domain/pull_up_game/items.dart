import 'package:flame/components.dart';
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

  PositionComponent component({double? speed}) {
    switch (this) {
      case Items.trashBin:
        return TrashBin(speed: speed ?? 0);
      case Items.pizza:
        return Pizza(speed: speed ?? 0);
      case Items.dollar:
        return Dollar(speed: speed ?? 0);
      case Items.fatPizza:
        return FatPizza(speed: speed ?? 0);
      case Items.dumbbell:
        return Dumbbell(speed: speed ?? 0);
      case Items.moneyBag:
        return MoneyBag(speed: speed ?? 0);
      case Items.bomb:
        return Bomb(speed: speed ?? 0);
      case Items.cocktail:
        return Cocktail(speed: speed ?? 0);
      case Items.molotov:
        return Molotov(speed: speed ?? 0);
    }
  }

  Vector2 getSize(double lineSize) {
    switch (this) {
      case Items.trashBin:
        return Vector2(lineSize / 1.5, lineSize / 2);
      case Items.pizza:
        return Vector2(lineSize * 0.6, lineSize * 0.6);
      case Items.dollar:
        return Vector2(lineSize / 2, lineSize / 2);
      case Items.fatPizza:
        return Vector2(lineSize * 0.7, lineSize * 0.7);
      case Items.dumbbell:
        return Vector2(lineSize / 2, lineSize / 2);
      case Items.moneyBag:
        return Vector2(lineSize / 2, lineSize / 2);
      case Items.bomb:
        return Vector2(lineSize / 1.5, lineSize / 1.5);
      case Items.cocktail:
        return Vector2(lineSize / 1.5, lineSize / 1.5);
      case Items.molotov:
        return Vector2(lineSize, lineSize / 3);
    }
  }
}
