import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dumbbell.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/fat_pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 1000 (or refactor it)
  trashBin(550),
  pizza(350),
  dollar(50),
  fatPizza(30),
  dumbbell(20);
  // trashBin(715),
  // pizza(210),
  // dollar(40),
  // fatPizza(20),
  // dumbbell(15);

  const Items(this.chance);

  final int chance;

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
    }
  }
}
