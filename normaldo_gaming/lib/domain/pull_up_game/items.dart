import 'package:flame/components.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/big_buddy_bin.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bomb.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/shredder.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/cocktail.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/homeless.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/fat_pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/hourglass.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/molotov.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/money_bag.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/punch.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/shredder_sword.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/shuriken.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 1000 (or refactor it)
  trashBin,
  pizza,
  dollar,
  fatPizza,
  homeless,
  moneyBag,
  bomb,
  cocktail,
  molotov,
  hourglass,
  punch,
  bigBuddyBin,
  shredder,
  shuriken,
  shredderSword;
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
      case Items.homeless:
        return Homeless();
      case Items.moneyBag:
        return MoneyBag();
      case Items.bomb:
        return Bomb();
      case Items.cocktail:
        return Cocktail();
      case Items.molotov:
        return Molotov();
      case Items.hourglass:
        return Hourglass();
      case Items.punch:
        return Punch();
      case bigBuddyBin:
        return BigBuddyBin();
      case shredder:
        return Shredder();
      case shuriken:
        return Shuriken();
      case shredderSword:
        return ShredderSword();
    }
  }

  Vector2 getSize(double lineSize) {
    switch (this) {
      case Items.trashBin:
        return Vector2(lineSize * 0.9, lineSize * 0.6);
      case Items.pizza:
        return Vector2(lineSize * 0.65, lineSize * 0.65);
      case Items.dollar:
        return Vector2(lineSize * 0.6, lineSize * 0.6);
      case Items.fatPizza:
        return Vector2(lineSize * 0.8, lineSize * 0.8);
      case Items.homeless:
        return Vector2(lineSize * 0.8, lineSize * 0.8);
      case Items.moneyBag:
        return Vector2(lineSize / 2, lineSize / 2);
      case Items.bomb:
        return Vector2(lineSize / 1.5, lineSize / 1.5);
      case Items.cocktail:
        return Vector2(lineSize / 1.5, lineSize / 1.5);
      case Items.molotov:
        return Vector2(lineSize, lineSize * 0.4);
      case Items.hourglass:
        return Vector2(lineSize / 1.5, lineSize / 1.5);
      case Items.punch:
        return Vector2(lineSize, lineSize * 0.6);
      case bigBuddyBin:
        return Vector2(lineSize * 6 / 1.2, lineSize * 3 * 0.95);
      case shredder:
        return Vector2(lineSize * 0.8, lineSize * 0.8);
      case shuriken:
        return Vector2(lineSize / 2, lineSize / 2);
      case shredderSword:
        return Vector2(lineSize * 0.8, lineSize * 0.8);
    }
  }
}
