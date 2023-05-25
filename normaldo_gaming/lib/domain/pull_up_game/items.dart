import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/dollar.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';

enum Items {
  // CHECK THAT SUM OF CHANCES MUST ALWAYS BE == 100 (or refactor it)
  trashBin(60),
  pizza(35),
  dollar(5);

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
    }
  }
}
