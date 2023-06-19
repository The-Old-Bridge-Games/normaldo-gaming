import 'dart:math';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/grid.dart';

class Item {
  final Component component;

  /// null means that line should be randomized
  final int? line;

  const Item({required this.component, this.line})
      : assert((line ?? 0) >= 0 && (line ?? 0) <= Grid.linesCount);
}

abstract class Level {
  double get frequency;

  List<Item> next();
}

class LinearLevel implements Level {
  LinearLevel({
    // required this.lineSize,
    required this.itemsChances,
    required this.frequency,
  }) : assert(
            itemsChances.values.fold<double>(
                    0, (previousValue, element) => previousValue + element) ==
                1,
            'Sum of all chances must be equal to 1');

  // final double lineSize;

  /// Items => chance
  final Map<Items, double> itemsChances;
  final _random = Random();

  @override
  final double frequency;

  List<Items> _itemsPool = [];

  @override
  List<Item> next() {
    if (_itemsPool.isNotEmpty) {
      final nextItem = _itemsPool.removeAt(_random.nextInt(_itemsPool.length));
      return [
        Item(component: nextItem.component(cubit: cubit)
            // ..size = _getSizeFromItem(nextItem),
            )
      ];
    }
    final pool = itemsChances.entries.fold<List<Items>>(
        [],
        (previousValue, element) => previousValue
          ..addAll(List.generate(
              (element.value * 1000).toInt(), (index) => element.key)));
    pool.shuffle(_random);
    _itemsPool = pool;

    return next();
  }

  // Vector2 _getSizeFromItem(Items item) {
  //   switch (item) {
  //     case Items.trashBin:
  //       return Vector2(lineSize / 1.5, lineSize / 2);
  //     case Items.pizza:
  //       return Vector2(lineSize * 0.6, lineSize * 0.6);
  //     case Items.dollar:
  //       return Vector2(lineSize / 2, lineSize / 2);
  //     case Items.fatPizza:
  //       return Vector2(lineSize * 0.7, lineSize * 0.7);
  //     case Items.dumbbell:
  //       return Vector2(lineSize / 2, lineSize / 2);
  //     case Items.moneyBag:
  //       return Vector2(lineSize / 2, lineSize / 2);
  //     case Items.bomb:
  //       return Vector2(lineSize / 1.5, lineSize / 1.5);
  //     case Items.cocktail:
  //       return Vector2(lineSize / 1.5, lineSize / 1.5);
  //     case Items.molotov:
  //       return Vector2(lineSize, lineSize / 3);
  //   }
  // }
}
