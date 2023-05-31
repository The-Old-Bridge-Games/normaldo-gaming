import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/has_aura_mixin.dart';
import 'package:normaldo_gaming/game/utils/solo_spawn.dart';

class Molotov extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        HasNgAudio,
        HasAura,
        SoloSpawn {
  Molotov({required this.cubit}) : super(anchor: Anchor.bottomCenter);

  final GameSessionCubit cubit;

  final _random = Random();

  late final double _changeLineTime =
      _random.nextInt(2) + 0.5 + _random.nextDouble();
  late final double _nextY;

  @override
  Aura get aura => Aura.red;

  @override
  PositionComponent get auraComponent => RectangleComponent(
        anchor: Anchor.center,
        size: Vector2(size.x, size.y / 3),
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      audio.playSfx(Sfx.bomb);
      cubit.takeHit();
      removeFromParent();
    }
    if (other is! Normaldo) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    audio.playSfx(Sfx.molotov);
    add(auraComponent..position = Vector2(size.x / 2, size.y - size.y / 3));
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('molotov.png'),
    ));
    add(RectangleHitbox(
      anchor: Anchor.center,
      size: Vector2(size.x, size.y / 3),
    ));

    add(TimerComponent(
      period: _changeLineTime,
      onTick: _changeLine,
      removeOnFinish: true,
    ));

    add(TimerComponent(
      period: _changeLineTime,
      onTick: () => audio.playSfx(Sfx.molotov),
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
    position.x -= levelConfigurator.itemSpeed(cubit.state.level) * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }

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
            speed: levelConfigurator.itemSpeed(cubit.state.level))));
  }
}
