import 'dart:math';

import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/grid.dart';

class Item {
  final Items item;

  /// null means that line should be randomized
  final int? line;

  const Item({required this.item, this.line})
      : assert((line ?? 0) >= 0 && (line ?? 0) <= Grid.linesCount);
}

abstract class Level {
  double get frequency;
  double get speed;

  List<Item> next();
}

class LinearLevel implements Level {
  LinearLevel({
    // required this.lineSize,
    required this.itemsChances,
    required this.frequency,
    required this.speed,
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

  @override
  final double speed;

  List<Items> _itemsPool = [];

  @override
  List<Item> next() {
    if (_itemsPool.isNotEmpty) {
      final nextItem = _itemsPool.removeAt(_random.nextInt(_itemsPool.length));
      return [Item(item: nextItem)];
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
}

class EventLevel implements Level {
  @override
  // TODO: implement frequency
  double get frequency => throw UnimplementedError();

  @override
  // TODO: implement speed
  double get speed => throw UnimplementedError();

  @override
  List<Item> next() {
    // TODO: implement next
    throw UnimplementedError();
  }
}
