import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

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
    final List<Items> itemsPool = [];
    Items.values.forEach((item) {
      itemsPool.addAll(List<Items>.generate(item.chance, (_) => item));
    });
    itemsPool.shuffle(random);
    final nextItem = itemsPool[random.nextInt(itemsPool.length)];
    return nextItem.component(cubit: bloc)..size = _getSizeFromItem(nextItem);
  }

  Vector2 _getSizeFromItem(Items item) {
    switch (item) {
      case Items.trashBin:
        return Vector2(grid.lineSize / 2 * 4 / 3, grid.lineSize / 2);
      case Items.pizza:
        return Vector2(grid.lineSize / 2, grid.lineSize / 2);
      case Items.dollar:
        return Vector2(grid.lineSize / 2, grid.lineSize / 2);
      case Items.heart:
        return Vector2(grid.lineSize / 2 * 0.8, grid.lineSize / 2 * 0.8);
    }
  }
}
