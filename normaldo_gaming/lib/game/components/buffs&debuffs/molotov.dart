import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Molotov extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Molotov() : super(anchor: Anchor.center);

  final _random = Random();

  late final double _changeLineTime =
      _random.nextInt(2) + 0.5 + _random.nextDouble();
  late final double _nextY;

  @override
  Aura get aura => Aura.red;

  @override
  PositionComponent get auraComponent => RectangleComponent(
        anchor: anchor,
        size: size,
        paint: auraPaint,
      );

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    speed = state.level.speed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      audio.playSfx(Sfx.bomb);
      (gameRef as PullUpGame).gameSessionCubit.takeHit();
      removeFromParent();
    }
    if (other is! Normaldo) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    audio.playSfx(Sfx.molotov);
    add(auraComponent);
    add(SpriteAnimationComponent(
      anchor: anchor,
      animation: SpriteAnimation.spriteList(
        [
          await Sprite.load('molotov1.png'),
          await Sprite.load('molotov2.png'),
        ],
        stepTime: 0.5,
      ),
      size: size,
    ));
    add(RectangleHitbox(
      anchor: Anchor.center,
      size: Vector2(size.x, size.y / 3),
    ));

    _nextY = _getNextY();

    add(RotateEffect.to(
        _nextY < y ? 0.35 : -0.35,
        EffectController(
          duration: _changeLineTime,
          reverseDuration: 1,
        )));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= speed * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
    if (position.x <
            gameRef.size.x -
                (Random().nextInt(gameRef.size.x ~/ 2) + size.x * 2) &&
        !_lineChanged) {
      _lineChanged = true;
      _changeLine();
    }
  }

  bool _lineChanged = false;

  double _getNextY() {
    final linesCentersY = (gameRef as PullUpGame).grid.linesCentersY;
    final isInBottom = y == linesCentersY.last;
    final isInTop = y == linesCentersY.first;
    double nextLineY;
    if (isInTop) {
      nextLineY = linesCentersY[1];
    } else if (isInBottom) {
      nextLineY = linesCentersY[linesCentersY.length - 2];
    } else {
      final nextIndex = _random.nextBool()
          ? linesCentersY.indexOf(y) - 1
          : linesCentersY.indexOf(y) + 1;
      nextLineY = linesCentersY[nextIndex];
    }
    return nextLineY;
  }

  void _changeLine() {
    add(MoveEffect.to(
        Vector2(x - 100, _nextY),
        EffectController(
          speed: speed,
        )));
  }

  @override
  bool get isSoloSpawn => false;
}
