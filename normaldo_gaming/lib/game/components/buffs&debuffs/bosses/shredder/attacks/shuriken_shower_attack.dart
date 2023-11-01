import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/attacks/shredder_attack.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/shredder.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/shuriken.dart';
import 'package:normaldo_gaming/game/components/grid.dart';

enum Corners { topLeft, topRight, bottomLeft, bottomRight }

final class Corner {
  const Corner({
    required this.corner,
    required this.position,
  });

  final Corners corner;
  final Vector2 position;
}

final class ShurikenShowerAttack extends ShredderAttack {
  ShurikenShowerAttack() : _completed = false;

  final List<Corner> corners = [];

  bool _completed;

  @override
  bool get completed => _completed;

  @override
  void start(Shredder shredder, Grid grid) {
    corners.addAll([
      Corner(position: shredder.size, corner: Corners.topLeft),
      Corner(
          position: Vector2(grid.size.x - shredder.size.x, shredder.size.y),
          corner: Corners.topRight),
      Corner(position: grid.size - shredder.size, corner: Corners.bottomRight),
      Corner(
          position: Vector2(shredder.size.x, grid.size.y - shredder.size.y),
          corner: Corners.bottomLeft),
    ]);
    corners.shuffle();
    _iterationAnimation(
      shredder,
      grid,
      0,
    );
  }

  void _iterationAnimation(Shredder shredder, Grid grid, int cornerIndex) {
    shredder.scale = Vector2.zero();
    final corner = corners[cornerIndex];
    final isFlippedHorizontally = shredder.shredderSprite.isFlippedHorizontally;
    if ((corner.corner == Corners.topLeft ||
            corner.corner == Corners.bottomLeft) &&
        !isFlippedHorizontally) {
      shredder.shredderSprite.flipHorizontallyAroundCenter();
    } else if ((corner.corner == Corners.topRight ||
            corner.corner == Corners.bottomRight) &&
        isFlippedHorizontally) {
      shredder.shredderSprite.flipHorizontallyAroundCenter();
    }
    shredder.position = corner.position;
    shredder.add(SequenceEffect([
      ScaleEffect.to(
          Vector2.all(1),
          EffectController(
            duration: 1,
          ), onComplete: () {
        addShurikens(corner, shredder, grid);
      }),
      RotateEffect.by(
        pi * 2,
        EffectController(
          duration: 0.3,
        ),
      ),
      ScaleEffect.to(Vector2.zero(), EffectController(duration: 0.5)),
    ], onComplete: () {
      final nextCornerIndex = cornerIndex + 1;
      if (nextCornerIndex < corners.length) {
        _iterationAnimation(shredder, grid, nextCornerIndex);
      } else {
        _completed = true;
        shredder.scale = Vector2.all(1);
      }
    }));
  }

  void addShurikens(Corner corner, Shredder shredder, Grid grid) {
    var shurikens = <Shuriken>[];
    switch (corner.corner) {
      case Corners.topLeft:
        shurikens = [
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(shredder.size.x * 2, shredder.size.y - 30),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(shredder.size.x * 2, shredder.size.y + 30),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(shredder.size.x, shredder.size.y + 60)
        ];
      case Corners.topRight:
        shurikens = [
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(
                grid.size.x - shredder.size.x * 2 - 20, shredder.size.y - 30),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(
                grid.size.x - shredder.size.x * 2, shredder.size.y + 35),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position =
                Vector2(grid.size.x - shredder.size.x - 30, shredder.size.y * 2)
        ];
      case Corners.bottomRight:
        shurikens = [
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(grid.size.x - shredder.size.x - 30,
                grid.size.y - shredder.size.y * 2),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(grid.size.x - shredder.size.x * 2,
                grid.size.y - shredder.size.y - 30),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(grid.size.x - shredder.size.x * 2,
                grid.size.y - shredder.size.y / 2),
        ];
      case Corners.bottomLeft:
        shurikens = [
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(
                shredder.size.x * 2 - 50, grid.size.y - shredder.size.y * 2),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(
                shredder.size.x * 2, grid.size.y - shredder.size.y - 30),
          Shuriken()
            ..size = Items.shuriken.getSize(grid.lineSize)
            ..position = Vector2(
                shredder.size.x * 2 + 15, grid.size.y - shredder.size.y / 2)
        ];
      default:
        break;
    }
    grid.addAll(shurikens);
  }
}
