import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bomb.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/cocktail.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dumbbell.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/fat_pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/money_bag.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 1000 (or refactor it)
  trashBin(576, 1),
  pizza(326, 0),
  dollar(44, 0),
  fatPizza(4, 3),
  dumbbell(8, 3),
  moneyBag(2, 0),
  bomb(20, 5),
  cocktail(20, 10);

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
    }
  }
}
