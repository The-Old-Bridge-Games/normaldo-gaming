import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/fat_pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 1000 (or refactor it)
  // trashBin(500),
  // pizza(495),
  // dollar(0),
  // fatPizza(5); // chance – 0.005
  trashBin(695), // chance – 0.625
  pizza(250), // chance – 0.25
  dollar(50), // chance – 0.05
  fatPizza(5); // chance – 0.005

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
    }
  }
}
