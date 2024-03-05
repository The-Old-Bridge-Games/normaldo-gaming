import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/grid.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
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
    audio.playSfx(Sfx.shredderPredator);
    boss.add(RotateEffect.by(
        (boss.isFlippedHorizontally ? pi : -pi) * 2,
        EffectController(
          duration: 0.5,
        )));
    boss.add(
      MoveToEffect(
          destination,
          EffectController(
            duration: 2,
            curve: Curves.linear,
          ), onComplete: () {
        _completed = true;
        _inProgress = false;
        boss.removeWhere((component) => component is ShredderSword);
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
