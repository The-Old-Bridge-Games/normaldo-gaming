import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:normaldo_gaming/core/roller/roller.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

class LineItem {
  final Items item;

  /// null means that line should be randomized
  final int? line;

  const LineItem({required this.item, this.line})
      : assert((line ?? 0) >= 0 && (line ?? 0) < Utils.linesCount);
}

abstract class Level extends Equatable {
  int get index;
  double get frequency;
  double get speed;

  List<LineItem> next();

  @override
  bool? get stringify => true;
}

class LinearLevel implements Level {
  LinearLevel({
    required this.index,
    required this.itemsChances,
    required this.itemRoller,
    required this.frequency,
    required this.speed,
  }) : assert(
            double.parse(itemsChances.values
                    .fold<double>(0.0,
                        (previousValue, element) => previousValue + element)
                    .toStringAsFixed(3)) ==
                1,
            'Sum of all chances must be equal to 1, current: ${double.parse(itemsChances.values.fold<double>(0.0, (previousValue, element) => previousValue + element).toStringAsFixed(3))} index: $index');

  /// Items => chance
  final Map<Items, double> itemsChances;
  final Roller<Items> itemRoller;
  final _random = Random();

  @override
  final int index;

  @override
  final double frequency;

  @override
  final double speed;

  final List<Items> _itemsPool = [];

  @override
  List<LineItem> next() {
    final nextItem = itemRoller.roll();
    return [LineItem(item: nextItem)];
    // if (_itemsPool.isNotEmpty) {
    //   final nextItem = _itemsPool.removeAt(_random.nextInt(_itemsPool.length));
    //   return [LineItem(item: nextItem)];
    // }
    // final pool = itemsChances.entries.fold<List<Items>>(
    //     [],
    //     (previousValue, element) => previousValue
    //       ..addAll(List.generate(
    //           (element.value * 1000).toInt(), (index) => element.key)));
    // pool.shuffle(_random);
    // _itemsPool.clear();
    // _itemsPool.addAll(pool);

    // return next();
  }

  LinearLevel copyWith({
    double? frequency,
    double? speed,
  }) =>
      LinearLevel(
        index: index,
        itemsChances: itemsChances,
        itemRoller: itemRoller,
        frequency: frequency ?? this.frequency,
        speed: speed ?? this.speed,
      );

  @override
  List<Object?> get props => [
        speed,
        frequency,
        itemsChances,
        index,
        itemRoller,
      ];

  @override
  bool? get stringify => true;
}
