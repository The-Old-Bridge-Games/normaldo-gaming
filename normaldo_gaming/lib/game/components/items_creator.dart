import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

import 'buffs&debuffs/pizza.dart';
import 'buffs&debuffs/trash_bin.dart';
import 'grid.dart';

class ItemsCreator extends TimerComponent
    with
        HasGameRef,
        FlameBlocReader<GameSessionCubit, GameSessionState>,
        FlameBlocListenable<GameSessionCubit, GameSessionState> {
  final Random random = Random();

  ItemsCreator({
    required this.grid,
    required double period,
  }) : super(period: period, repeat: true);

  final Grid grid;

  @override
  void onNewState(GameSessionState state) {}

  @override
  void onTick() {
    gameRef.add(_getNextItem()
      ..position = Vector2(
        gameRef.size.x + (grid.lineSize * 4 / 3) / 2,
        grid.linesCentersY[random.nextInt(grid.linesCentersY.length)],
      ));
  }

  PositionComponent _getNextItem() {
    final chance = random.nextInt(101) / 100;
    if (chance <= Items.trashBin.chance) {
      return TrashBin(cubit: bloc)
        ..size = Vector2(grid.lineSize / 2 * 4 / 3, grid.lineSize / 2);
    } else {
      return Pizza(cubit: bloc)
        ..size = Vector2(grid.lineSize / 2, grid.lineSize / 2);
    }
  }
}
