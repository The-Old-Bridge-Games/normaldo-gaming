import 'dart:math';

import 'package:flutter/material.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/grid.dart';

class Item {
  final Items item;

  /// null means that line should be randomized
  final int? line;

  const Item({required this.item, this.line})
      : assert((line ?? 0) >= 0 && (line ?? 0) < Grid.linesCount);
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
            double.parse(itemsChances.values
                    .fold<double>(
                        0, (previousValue, element) => previousValue + element)
                    .toStringAsFixed(3)) ==
                1,
            'Sum of all chances must be equal to 1');

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
  EventLevel(
    this._items, {
    required this.frequency,
    required this.speed,
    required this.onFinish,
  });

  EventLevel.trashWall({
    required this.speed,
    required this.frequency,
    required this.onFinish,
  }) : _items = [
          [Item(item: Items.bomb, line: Random().nextInt(Grid.linesCount))],
          [],
          [
            const Item(item: Items.trashBin, line: 0),
            const Item(item: Items.trashBin, line: 1),
            const Item(item: Items.trashBin, line: 2),
            const Item(item: Items.trashBin, line: 3),
            const Item(item: Items.trashBin, line: 4),
          ]
        ];

  EventLevel.guardedPizza({
    required this.speed,
    required this.onFinish,
  }) : frequency = 200 {
    final firstLine = Random().nextInt(3) + 1;
    _items = [
      [Item(item: Items.trashBin, line: firstLine)],
      [
        Item(item: Items.trashBin, line: firstLine - 1),
        Item(item: Items.fatPizza, line: firstLine),
        Item(item: Items.trashBin, line: firstLine + 1),
      ],
      [
        Item(item: Items.trashBin, line: firstLine),
      ],
    ];
  }

  EventLevel.cursedPath({
    required this.speed,
    required this.onFinish,
  }) : frequency = 200 {
    final random = Random();
    final eventLength = random.nextInt(7) + 8;
    var livingIndex = random.nextInt(Grid.linesCount);
    final livingPath = List.generate(eventLength, (index) {
      if (index == 0) {
        return livingIndex;
      } else {
        if (livingIndex == 0) {
          livingIndex++;
        } else if (livingIndex == Grid.linesCount - 1) {
          livingIndex--;
        } else {
          livingIndex = random.nextBool() ? livingIndex + 1 : livingIndex - 1;
        }
        return livingIndex;
      }
    });
    _items = [];
    final items = List.generate(
        livingPath.length,
        (columnIndex) => List.generate(Grid.linesCount, (index) {
              if (index != livingPath[columnIndex]) {
                return Item(item: Items.trashBin, line: index);
              }
              if (columnIndex != eventLength - 1) {
                return Item(item: Items.pizza, line: index);
              } else {
                return Item(item: Items.cocktail, line: index);
              }
            }));
    for (var i = 0; i < items.length; i++) {
      _items.addAll([
        items[i],
        [],
      ]);
    }
  }

  final void Function() onFinish;
  late final List<List<Item>> _items;

  @override
  final double frequency;

  @override
  final double speed;

  int _counter = 0;

  bool _finished = false;
  bool get finished => _finished;

  @override
  @mustCallSuper
  List<Item> next() {
    if (finished) return [];
    if (_counter == _items.length) {
      _finished = true;
      onFinish();
      return next();
    }
    final item = _items[_counter];
    _counter++;
    return item;
  }
}
