import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';

import 'grid.dart';

class ItemsCreator extends TimerComponent
    with HasGameRef, FlameBlocReader<GameSessionCubit, GameSessionState> {
  final Random random = Random();

  ItemsCreator({
    required this.grid,
    required double period,
    required this.level,
  }) : super(period: period, repeat: true);

  final Grid grid;
  final int level;

  Items? _forcedItem;

  void forceItem(Items item) {
    _forcedItem = item;
  }

  @override
  void onTick() {
    final itemComponent = _getNextItem();
    // gameRef.add(
    //   TrashBin(cubit: bloc)
    //     ..size = _getSizeFromItem(Items.trashBin)
    //     ..position = Vector2(
    //       gameRef.size.x + 100,
    //       grid.linesCentersY[2],
    //     ),
    // );
    gameRef.add(itemComponent
      ..position = Vector2(
        gameRef.size.x + itemComponent.size.x,
        grid.linesCentersY[random.nextInt(grid.linesCentersY.length)],
      ));
  }

  PositionComponent _getNextItem() {
    if (_forcedItem != null) {
      final forcedItem = _forcedItem!;
      _forcedItem = null;
      return forcedItem.component(cubit: bloc)
        ..size = _getSizeFromItem(forcedItem);
    }
    Items getNextItem(List<Items> itemsPool) {
      final item = itemsPool[random.nextInt(itemsPool.length)];
      if (((item.component(cubit: bloc) is GameObject) &&
              (item.component(cubit: bloc) as GameObject).isSoloSpawn) &&
          gameRef.children.any((element) =>
              element is GameObject && ((element as GameObject).isSoloSpawn))) {
        return getNextItem(itemsPool);
      }
      return item;
    }

    final List<Items> itemsPool = [];
    for (var item in Items.values) {
      if (level >= item.startLevel) {
        itemsPool.addAll(List<Items>.generate(item.chance, (_) => item));
      }
    }
    itemsPool.shuffle(random);
    final nextItem = getNextItem(itemsPool);
    return nextItem.component(cubit: bloc)..size = _getSizeFromItem(nextItem);
  }

  Vector2 _getSizeFromItem(Items item) {
    switch (item) {
      case Items.trashBin:
        return Vector2(grid.lineSize / 1.5, grid.lineSize / 2);
      case Items.pizza:
        return Vector2(grid.lineSize * 0.6, grid.lineSize * 0.6);
      case Items.dollar:
        return Vector2(grid.lineSize / 2, grid.lineSize / 2);
      case Items.fatPizza:
        return Vector2(grid.lineSize * 0.7, grid.lineSize * 0.7);
      case Items.dumbbell:
        return Vector2(grid.lineSize / 2, grid.lineSize / 2);
      case Items.moneyBag:
        return Vector2(grid.lineSize / 2, grid.lineSize / 2);
      case Items.bomb:
        return Vector2(grid.lineSize / 1.5, grid.lineSize / 1.5);
      case Items.cocktail:
        return Vector2(grid.lineSize / 1.5, grid.lineSize / 1.5);
      case Items.molotov:
        return Vector2(grid.lineSize, grid.lineSize / 3);
    }
  }
}
