import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/shuriken.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/grid.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

enum Corners { topLeft, topRight, bottomLeft, bottomRight }

final class Corner {
  const Corner({
    required this.corner,
    required this.position,
  });

  final Corners corner;
  final Vector2 position;
}

abstract base class ShredderAttack {
  bool get processing;
  bool get completed;

  void start(Shredder shredder, Grid grid);
}

final class PredatorAttack extends ShredderAttack {
  PredatorAttack()
      : _processing = false,
        _completed = false;

  bool _processing, _completed;

  @override
  bool get processing => _processing;

  @override
  bool get completed => _completed;

  @override
  void start(Shredder shredder, Grid grid) {
    final topRndPosition = Vector2(grid.size.x / 2, -100);
    final bottomRndPosition = Vector2(grid.size.x / 2, grid.size.y + 100);
    final fromTop = Random().nextBool();
    shredder.position = fromTop ? topRndPosition : bottomRndPosition;
    final distanceToNormaldo =
        shredder.position.distanceTo(grid.normaldo.position);
    shredder.add(MoveToEffect(
        grid.normaldo.position,
        EffectController(
          duration: 2,
        ), onComplete: () {
      _completed = true;
    }));
  }
}

final class ShurikenShowerAttack extends ShredderAttack {
  ShurikenShowerAttack()
      : _processing = false,
        _completed = false;

  final List<Corner> corners = [];

  bool _processing, _completed;

  @override
  bool get processing => _processing;

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
    // corners.shuffle();
    _iterationAnimation(
      shredder,
      grid,
      0,
    );
  }

  void _iterationAnimation(Shredder shredder, Grid grid, int cornerIndex) {
    shredder.scale = Vector2.zero();
    final corner = corners[cornerIndex];
    final isFlippedHorizontally =
        shredder._shredderSprite.isFlippedHorizontally;
    if ((corner.corner == Corners.topLeft ||
            corner.corner == Corners.bottomLeft) &&
        !isFlippedHorizontally) {
      shredder._shredderSprite.flipHorizontallyAroundCenter();
    } else if (corner.corner == Corners.topRight ||
        corner.corner == Corners.bottomRight && isFlippedHorizontally) {
      shredder._shredderSprite.flipHorizontallyAroundCenter();
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

class Shredder extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        Eatable,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Shredder() : super(anchor: Anchor.center);

  late final eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  final List<ShredderAttack> _attacks = [];

  late final SpriteComponent _shredderSprite;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    if (!hearsBloc) return;
    speed = state.level.speed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && !disabled) {
      (gameRef as PullUpGame).gameSessionCubit.takeHit();
      audio.playSfx(Sfx.binCrash);
      // attack =
    }
    if (other is GameObject && !disabled) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    onRemoved = () {
      bloc.add(const LevelEvent.finishMiniGame());
    };
    disabled = true;
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    _shredderSprite = SpriteComponent(
      size: size,
      sprite: await Sprite.load('shredder.png'),
    );
    add(_shredderSprite);

    add(eatingHitbox);

    final grid = (gameRef as PullUpGame).grid;
    _attacks.addAll([
      ShurikenShowerAttack()..start(this, grid),
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
    ]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_attacks.isNotEmpty) {
      if (_attacks.first.completed) {
        _attacks.removeAt(0);
        if (_attacks.isNotEmpty) {
          _attacks.first.start(this, (gameRef as PullUpGame).grid);
        }
      }
    } else {
      removeFromParent();
    }
  }

  @override
  bool get isSoloSpawn => true;

  @override
  Items get item => Items.shredder;
}
