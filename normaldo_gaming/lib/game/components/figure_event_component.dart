import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';

import 'grid.dart';

class FigureEventComponent extends PositionComponent {
  FigureEventComponent({
    required this.figure,
    required this.lineSize,
    required this.linesCentersY,
    required this.onFinish,
  });

  final FigureEvent figure;
  final double lineSize;
  final List<double> linesCentersY;
  final void Function() onFinish;

  @override
  FutureOr<void> onLoad() {
    final List<List<Item>> matrix = figure.when(
      trashWall: () => [
        [Item(item: Items.bomb, line: Random().nextInt(Grid.linesCount))],
        [
          const Item(item: Items.trashBin, line: 0),
          const Item(item: Items.trashBin, line: 1),
          const Item(item: Items.trashBin, line: 2),
          const Item(item: Items.trashBin, line: 3),
          const Item(item: Items.trashBin, line: 4),
        ]
      ],
      guardedPizza: () => [],
      cursedPath: () => [],
    );

    _addItemsFromMatrix(matrix);

    Future.delayed(const Duration(seconds: 3)).whenComplete(() => onFinish());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (children.isEmpty) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void removeFromParent() {
    removeAll(children);
    super.removeFromParent();
  }

  void _addItemsFromMatrix(List<List<Item>> matrix) {
    figure.when(
      trashWall: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          final columnPadding = xOffset *
              (Items.trashBin.getSize(lineSize).x +
                  (Random().nextInt(size.x ~/ 3).toDouble()));
          for (final item in column) {
            final itemSize = item.item.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..position = Vector2(
                  size.x * 1.3 + (xOffset * itemSize.x) + columnPadding,
                  linesCentersY[item.line ?? 0]));
          }
        }
      },
      guardedPizza: () {},
      cursedPath: () {},
    );
  }
}
