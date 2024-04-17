import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/item_components/pizza.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

class FigureEventComponent extends PositionComponent
    with HasGameRef<PullUpGame> {
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

  var _initiated = false;
  var _finished = false;

  @override
  Future<void> onLoad() async {
    // 4DEV
    // add(RectangleComponent(
    //     size: size,
    //     paint: Paint()..color = BasicPalette.blue.color.withOpacity(0.5)));
    final List<List<LineItem>> matrix = figure.when(
      trashWall: () => [
        [
          LineItem(
              item: Items.boombox, line: Random().nextInt(Utils.linesCount))
        ],
        [
          const LineItem(item: Items.cone, line: 0),
          const LineItem(item: Items.cone, line: 1),
          const LineItem(item: Items.cone, line: 2),
          const LineItem(item: Items.cone, line: 3),
          const LineItem(item: Items.cone, line: 4),
        ]
      ],
      guardedPizza: () {
        final firstLine = Random().nextInt(linesCentersY.length - 2) + 1;
        return [
          [LineItem(item: Items.trashBin, line: firstLine)],
          [
            LineItem(item: Items.cone, line: firstLine - 1),
            LineItem(item: Items.fatPizza, line: firstLine),
            LineItem(item: Items.cone, line: firstLine + 1),
          ],
          [
            LineItem(item: Items.cone, line: firstLine - 1),
            LineItem(item: Items.cone, line: firstLine),
            LineItem(item: Items.cone, line: firstLine + 1),
          ],
        ];
      },
      cursedPath: () {
        final random = Random();
        final eventLength = random.nextInt(6) + 5;
        var livingIndex = random.nextInt(Utils.linesCount);
        final livingPath = List.generate(eventLength, (index) {
          if (index == 0) {
            return livingIndex;
          } else {
            if (livingIndex == 0) {
              livingIndex++;
            } else if (livingIndex == Utils.linesCount - 1) {
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
            (columnIndex) => List.generate(Utils.linesCount, (index) {
                  if (index != livingPath[columnIndex]) {
                    return LineItem(item: Items.cone, line: index);
                  }
                  if (columnIndex != eventLength - 1) {
                    return LineItem(item: Items.pizza, line: index);
                  } else {
                    return LineItem(item: Items.cocktail, line: index);
                  }
                }));
      },
      punchWave: () {
        final alreadyUsed = <int>[];
        return List.generate(3, (index) {
          var excludedLine = Random().nextInt(Utils.linesCount);
          while (alreadyUsed.contains(excludedLine)) {
            excludedLine = Random().nextInt(Utils.linesCount);
          }
          alreadyUsed.add(excludedLine);
          return List.generate(
              Utils.linesCount - 1,
              (index) => LineItem(
                    item: Items.punch,
                    line: index >= excludedLine ? index + 1 : index,
                  ));
        });
      },
      bigBuddyBin: () {
        return [
          [
            LineItem(
                item: [
                  Items.cone,
                  Items.trashBin,
                  Items.bird,
                  Items.policeAlarm,
                ].random(),
                line: Random().nextInt(3))
          ],
        ];
      },
      only2Lines: () {
        final List<int> usedIndexes = [];
        int getLineYIndex({List<int>? exclude}) {
          final indexes = List.generate(Utils.linesCount, (index) => index);
          for (final exclusion in exclude ?? []) {
            if (indexes.contains(exclusion)) {
              indexes.remove(exclusion);
            }
          }
          final index = indexes[Random().nextInt(indexes.length)];
          if (usedIndexes
              .any((e) => index + 1 == e || index - 1 == e || index == e)) {
            return getLineYIndex(exclude: [index, index - 1, index + 1]);
          }
          return index;
        }

        usedIndexes.add(getLineYIndex());
        usedIndexes.add(getLineYIndex());

        return List.generate(8, (index) {
          final list = List.generate(
              Utils.linesCount,
              (index) => LineItem(
                    item: Items.cone,
                    line: index,
                  ));
          list.removeWhere((e) {
            return usedIndexes.contains(e.line);
          });
          return list;
        });
      },
      unreachablePizza: () {
        final firstLine = Random().nextInt(linesCentersY.length - 2) + 1;
        return [
          [
            LineItem(item: Items.boombox, line: firstLine - 1),
            LineItem(item: Items.boombox, line: firstLine),
            LineItem(item: Items.boombox, line: firstLine + 1),
          ],
          [
            LineItem(item: Items.boombox, line: firstLine - 1),
            LineItem(item: Items.fatPizza, line: firstLine),
            LineItem(item: Items.boombox, line: firstLine + 1),
          ],
          [
            LineItem(item: Items.boombox, line: firstLine - 1),
            LineItem(item: Items.boombox, line: firstLine),
            LineItem(item: Items.boombox, line: firstLine + 1),
          ],
        ];
      },
      slowMo: () {
        return [
          List.generate(Utils.linesCount,
              (index) => LineItem(item: Items.cocktail, line: index)),
          ...List.generate(
              Random().nextInt(6) + 5,
              (index) => List.generate(Utils.linesCount,
                  (index) => LineItem(item: Items.pizza, line: index))),
        ];
      },
      winLabel: (item) => [
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 1),
          LineItem(item: item, line: 2),
        ],
        [
          LineItem(item: item, line: 3),
        ],
        [
          LineItem(item: item, line: 4),
        ],
        [
          LineItem(item: item, line: 2),
          LineItem(item: item, line: 3),
        ],
        [
          LineItem(item: item, line: 4),
        ],
        [
          LineItem(item: item, line: 3),
        ],
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 1),
          LineItem(item: item, line: 2),
        ],
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 4),
        ],
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 1),
          LineItem(item: item, line: 2),
          LineItem(item: item, line: 3),
          LineItem(item: item, line: 4),
        ],
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 4),
        ],
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 1),
          LineItem(item: item, line: 2),
          LineItem(item: item, line: 3),
          LineItem(item: item, line: 4),
        ],
        [
          LineItem(item: item, line: 0),
        ],
        [
          LineItem(item: item, line: 1),
        ],
        [
          LineItem(item: item, line: 2),
        ],
        [
          LineItem(item: item, line: 3),
        ],
        [
          LineItem(item: item, line: 0),
          LineItem(item: item, line: 1),
          LineItem(item: item, line: 2),
          LineItem(item: item, line: 3),
          LineItem(item: item, line: 4),
        ],
      ],
    );

    _addLineItemsFromMatrix(matrix);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!_initiated) return;
    final gameObjects = children.whereType<Item>();
    if (gameObjects.isEmpty && _finished) removeFromParent();
    figure.maybeWhen(punchWave: () {
      if ((gameObjects.every((e) =>
              e.absolutePosition.x < (gameRef as PullUpGame).grid.size.x)) &&
          _finished) {
        onFinish();
      }
    }, orElse: () {
      if (gameObjects.isEmpty && !_finished) {
        onFinish();
        _finished = true;
      } else if (gameObjects.isNotEmpty && !_finished) {
        if ((gameObjects.every((e) =>
            e.absolutePosition.x < (gameRef as PullUpGame).grid.size.x))) {
          onFinish();
          _finished = true;
        }
      }
    });
    super.update(dt);
  }

  @override
  void removeFromParent() {
    if (!_finished) {
      onFinish();
      _finished = true;
    }
    removeAll(children);
    super.removeFromParent();
  }

  @override
  void onRemove() {
    if (!_finished) {
      onFinish();
      _finished = true;
    }
    super.onRemove();
  }

  void _addLineItemsFromMatrix(List<List<LineItem>> matrix) {
    gameRef.grid.resumeLines();
    gameRef.grid.removeWhere((component) =>
        component is Item && component.position.x > gameRef.size.x);
    figure.when(
      trashWall: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          final columnPadding = xOffset *
              (Items.cone.getSize(lineSize).x +
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
                  size.x * 1.3 + (xOffset * Items.cone.getSize(lineSize).x * 3),
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
                if (matrix.indexOf(column) == matrix.length - 1) {
                  _finished = true;
                }
              }
            },
          ));
        }
        (gameRef as PullUpGame).grid.resumeLines();
      },
      bigBuddyBin: () {
        final item = matrix.first.first;
        final itemSize = item.item.getSize(lineSize);
        final component = item.item.component() as AttackingItem
          ..anchor = Anchor.topCenter
          ..speedMultiplier = 1.3
          ..size = item.item == Items.trashBin ? itemSize : itemSize * 4;
        component.position = Vector2(
          size.x + component.size.x,
          linesCentersY[matrix.first.first.line ?? 0],
        );
        add(component);
        component.strength = 10;
      },
      only2Lines: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          for (final item in column) {
            final itemSize = Items.cone.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..speedMultiplier = 1.5
              ..position = Vector2(
                  size.x * 1.3 + (xOffset * Items.cone.getSize(lineSize).x),
                  linesCentersY[item.line ?? 0]));
          }
        }
      },
      slowMo: () {
        for (final column in matrix) {
          final xOffset = matrix.indexOf(column);
          for (final item in column) {
            final itemSize = item.item.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..position = Vector2(
                  size.x * (xOffset > 0 ? 2.6 : 1.3) +
                      (xOffset * item.item.getSize(lineSize).x * 2),
                  linesCentersY[item.line ?? 0]));
          }
        }
        children.whereType<Pizza>().forEach((element) {
          element.speedMultiplier = 2;
        });
      },
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
      winLabel: (_) {
        final gapIndexes = [7, 10];
        double xOffset = 0;
        for (final column in matrix) {
          xOffset += Items.dollar.getSize(lineSize).x * 1.5;
          if (gapIndexes.contains(matrix.indexOf(column))) {
            xOffset += 100;
          }
          for (final item in column) {
            final itemSize = item.item.getSize(lineSize);
            add(item.item.component()
              ..size = itemSize
              ..position = Vector2(
                size.x * 1.3 + xOffset,
                linesCentersY[item.line ?? 0],
              ));
          }
        }
      },
    );
    _initiated = true;
  }
}
