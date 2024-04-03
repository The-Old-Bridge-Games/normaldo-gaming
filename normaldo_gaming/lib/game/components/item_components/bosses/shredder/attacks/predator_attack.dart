import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/grid.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/ninja_foot/ninja_foot.dart';
import 'package:normaldo_gaming/game/components/item_components/shredder_sword.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'boss_attack.dart';

final class PredatorAttack extends BossAttack with HasNgAudio {
  PredatorAttack()
      : _completed = false,
        _inProgress = false;

  bool _completed;
  bool _inProgress;

  @override
  bool get completed => _completed;

  @override
  bool get inProgress => _inProgress;

  SpriteAnimationGroupComponent<NinjaFootState> bossComp(Boss boss) =>
      boss as SpriteAnimationGroupComponent<NinjaFootState>;

  @override
  void start(Boss boss, Grid grid) {
    _inProgress = true;
    final rndXPos =
        (-100 + (Random().nextInt(grid.size.x.toInt() + 100)).toDouble());
    final topRndPosition = Vector2(rndXPos, -boss.size.y);
    final bottomRndPosition = Vector2(rndXPos, grid.size.y + boss.size.y);
    final fromTop = Random().nextBool();
    boss.position = fromTop ? topRndPosition : bottomRndPosition;
    boss.scale = Vector2.all(1);
    _flipIfNeeded(boss, grid.normaldo);
    final sword = ShredderSword();
    boss.add(sword
      ..size = Items.shredderSword.getSize(grid.lineSize)
      ..position = boss.isFlippedHorizontally
          ? Vector2(boss.size.x + 10, 10)
          : Vector2(-boss.size.x / 2 + 20, 10)
      ..angle = boss.isFlippedHorizontally ? -0.4 : 0.4);
    if (boss.isFlippedHorizontally) {
      sword.flipHorizontallyAroundCenter();
    }
    final nPosition = grid.normaldo.position;
    final distinction = nPosition - boss.position;
    var destination = nPosition + distinction;
    while (destination.y > 0 && destination.y < grid.size.y) {
      destination += distinction;
    }
    if (destination.y > grid.size.y + boss.size.y) {
      destination.y = grid.size.y + boss.size.y;
    }
    if (destination.y < -boss.size.y) {
      destination.y = -boss.size.y;
    }
    audio.playSfx(Sfx.shredderPredator);
    bossComp(boss).current = NinjaFootState.predator;
    bossComp(boss).lookAt(grid.normaldo.position);
    boss.add(TimerComponent(
        period: 0.5,
        onTick: () {
          bossComp(boss).current = NinjaFootState.predator2;
        }));
    boss.add(SizeEffect.to(
      boss.size * 1.6,
      EffectController(
        duration: 0.3,
        startDelay: 0.5,
        reverseDuration: 0.3,
      ),
      onComplete: () {
        if (bossComp(boss).current != NinjaFootState.idle) {
          bossComp(boss).current = NinjaFootState.predator;
        }
      },
    ));
    boss.add(
      MoveToEffect(
          destination,
          EffectController(
            speed: 500,
            curve: Curves.linear,
          ), onComplete: () {
        boss.angle = 0;
        _completed = true;
        _inProgress = false;
        bossComp(boss).current = NinjaFootState.idle;
      }),
    );
  }

  void _flipIfNeeded(Boss boss, Normaldo normaldo) {
    if (boss.center.x > normaldo.center.x && boss.isFlippedHorizontally) {
      boss.flipHorizontallyAroundCenter();
    }
    if (boss.center.x < normaldo.center.x && !boss.isFlippedHorizontally) {
      boss.flipHorizontallyAroundCenter();
    }
  }
}
