import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/attacks/shredder_attack.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/shredder.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/shredder_sword.dart';
import 'package:normaldo_gaming/game/components/grid.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';

final class PredatorAttack extends ShredderAttack with HasNgAudio {
  PredatorAttack() : _completed = false;

  bool _completed;

  @override
  bool get completed => _completed;

  @override
  void start(Shredder shredder, Grid grid) {
    final rndXPos =
        (-100 + (Random().nextInt(grid.size.x.toInt() + 100)).toDouble());
    final topRndPosition = Vector2(rndXPos, -shredder.size.y);
    final bottomRndPosition = Vector2(rndXPos, grid.size.y + shredder.size.y);
    final fromTop = Random().nextBool();
    shredder.position = fromTop ? topRndPosition : bottomRndPosition;
    shredder.scale = Vector2.all(1);
    _flipIfNeeded(shredder, grid.normaldo);
    final sword = ShredderSword();
    shredder.add(sword
      ..size = Items.shredderSword.getSize(grid.lineSize)
      ..position = shredder.shredderSprite.isFlippedHorizontally
          ? Vector2(shredder.size.x + 10, 10)
          : Vector2(-shredder.size.x / 2 + 20, 10)
      ..angle = shredder.shredderSprite.isFlippedHorizontally ? -0.4 : 0.4);
    if (shredder.shredderSprite.isFlippedHorizontally) {
      sword.flipHorizontallyAroundCenter();
    }
    final nPosition = grid.normaldo.position;
    final distinction = nPosition - shredder.position;
    var destination = nPosition + distinction;
    while (destination.y > 0 && destination.y < grid.size.y) {
      destination += distinction;
    }
    audio.playSfx(Sfx.shredderPredator);
    shredder.add(RotateEffect.by(
        (shredder.shredderSprite.isFlippedHorizontally ? pi : -pi) * 2,
        EffectController(
          duration: 1,
        )));
    shredder.add(
      MoveToEffect(
          destination,
          EffectController(
            speed: shredder.speed * 1.2,
            curve: Curves.linear,
          ), onComplete: () {
        _completed = true;
        shredder.removeWhere((component) => component is ShredderSword);
      }),
    );
  }

  void _flipIfNeeded(Shredder shredder, Normaldo normaldo) {
    if (shredder.center.x > normaldo.center.x &&
        shredder.shredderSprite.isFlippedHorizontally) {
      shredder.shredderSprite.flipHorizontallyAroundCenter();
    }
    if (shredder.center.x < normaldo.center.x &&
        !shredder.shredderSprite.isFlippedHorizontally) {
      shredder.shredderSprite.flipHorizontallyAroundCenter();
    }
  }
}
