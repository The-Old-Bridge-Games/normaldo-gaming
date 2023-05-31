import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dumbbell.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/fat_pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/money_bag.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 1000 (or refactor it)
  trashBin(596, 1),
  pizza(346, 0),
  dollar(44, 0),
  fatPizza(4, 3),
  dumbbell(8, 3),
  moneyBag(2, 0);
  // trashBin(0),
  // pizza(200),
  // dollar(100),
  // fatPizza(100),
  // dumbbell(100),
  // moneyBag(100);

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
    }
  }
}
