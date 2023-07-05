import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/big_buddy_bin.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

import 'grid.dart';

class FigureEventComponent extends PositionComponent with HasGameRef {
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

  var _finished = false;

  @override
  Future<void> onLoad() async {
    // 4DEV
    // add(RectangleComponent(
    //     size: size,
    //     paint: Paint()..color = BasicPalette.blue.color.withOpacity(0.5)));
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
      guardedPizza: () {
        final firstLine = Random().nextInt(linesCentersY.length - 2) + 1;
        return [
          [Item(item: Items.trashBin, line: firstLine)],
          [
            Item(item: Items.trashBin, line: firstLine - 1),
            Item(item: Items.fatPizza, line: firstLine),
            Item(item: Items.trashBin, line: firstLine + 1),
          ],
          [
            Item(item: Items.trashBin, line: firstLine - 1),
            Item(item: Items.trashBin, line: firstLine),
            Item(item: Items.trashBin, line: firstLine + 1),
          ],
        ];
      },
      cursedPath: () {
        final random = Random();
        final eventLength = random.nextInt(6) + 5;
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
              livingIndex =
                  random.nextBool() ? livingIndex + 1 : livingIndex - 1;
            }
            return livingIndex;
          }
        });
        return List.generate(
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
      },
      punchWave: () {
        final alreadyUsed = <int>[];
        return List.generate(3, (index) {
          var excludedLine = Random().nextInt(Grid.linesCount);
          while (alreadyUsed.contains(excludedLine)) {
            excludedLine = Random().nextInt(Grid.linesCount);
          }
          alreadyUsed.add(excludedLine);
          return List.generate(
              Grid.linesCount - 1,
              (index) => Item(
                    item: Items.punch,
                    line: index >= excludedLine ? index + 1 : index,
                  ));
        });
      },
      bigBuddyBin: () {
        return [
          [Item(item: Items.bigBuddyBin, line: Random().nextInt(3))],
        ];
      },
      only2Lines: () {
        return [];
      },
      unreachablePizza: () {
        final firstLine = Random().nextInt(linesCentersY.length - 2) + 1;
        return [
          [
            Item(item: Items.bomb, line: firstLine - 1),
            Item(item: Items.bomb, line: firstLine),
            Item(item: Items.bomb, line: firstLine + 1),
          ],
          [
            Item(item: Items.bomb, line: firstLine - 1),
            Item(item: Items.fatPizza, line: firstLine),
            Item(item: Items.bomb, line: firstLine + 1),
          ],
          [
            Item(item: Items.bomb, line: firstLine - 1),
            Item(item: Items.bomb, line: firstLine),
            Item(item: Items.bomb, line: firstLine + 1),
          ],
        ];
      },
      slowMo: () {
        return [];
      },
    );

    _addItemsFromMatrix(matrix);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    final gameObjects = children.where((element) => element is GameObject);
    if (gameObjects.isEmpty && _finished) removeFromParent();
    if (gameObjects.isNotEmpty) {
      if ((gameObjects.every((e) =>
              (e as GameObject).position.x <
              (gameRef as PullUpGame).grid.normaldo.position.x)) &&
          !_finished) {
        _finished = true;
        onFinish();
      }
    }
    super.update(dt);
  }

  @override
  void removeFromParent() {
    onFinish();
    removeAll(children);
    super.removeFromParent();
  }

  @override
  void onRemove() {
    onFinish();
    super.onRemove();
  }

  void _addItemsFromMatrix(List<List<Item>> matrix) {
    (gameRef as PullUpGame).grid.resumeLines();
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
      guardedPizza: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          for (final item in column) {
            final itemSize = item.item.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..position = Vector2(size.x * 1.3 + (xOffset * itemSize.x * 2.1),
                  linesCentersY[item.line ?? 0]));
          }
        }
      },
      cursedPath: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          for (final item in column) {
            final itemSize = item.item.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..position = Vector2(
                  size.x * 1.3 +
                      (xOffset * Items.trashBin.getSize(lineSize).x * 4),
                  linesCentersY[item.line ?? 0]));
          }
        }
      },
      punchWave: () async {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          add(TimerComponent(
            period: (2 * xOffset).toDouble(),
            removeOnFinish: true,
            onTick: () {
              for (final item in column) {
                final itemSize = item.item.getSize(lineSize);
                (gameRef as PullUpGame).grid.resumeLines();
                add(item.item.component()
                  ..size = itemSize
                  ..position = Vector2(
                      (size.x) + Items.punch.getSize(lineSize).x,
                      linesCentersY[item.line ?? 0]));
              }
            },
          ));
        }
        (gameRef as PullUpGame).grid.resumeLines();
      },
      bigBuddyBin: () {
        final item = matrix.first.first;
        final itemSize = item.item.getSize(lineSize);
        add((item.item.component() as GameObject)
          ..anchor = Anchor.topCenter
          ..size = itemSize
          ..position = Vector2(
            size.x + itemSize.x,
            linesCentersY[matrix.first.first.line ?? 0] - lineSize / 2,
          ));
        (children.firstWhere((element) => element is BigBuddyBin)
                as BigBuddyBin)
            .speed *= 1.5;
      },
      only2Lines: () {},
      slowMo: () {},
      unreachablePizza: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          for (final item in column) {
            final itemSize = item.item.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..position = Vector2(size.x * 1.3 + (xOffset * itemSize.x * 2.1),
                  linesCentersY[item.line ?? 0]));
          }
        }
      },
    );
  }
}
