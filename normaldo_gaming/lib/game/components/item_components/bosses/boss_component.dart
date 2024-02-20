import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/game/components/boss_hp.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

mixin Boss on PositionComponent, HasGameRef<PullUpGame> {
  int get hp;
  set hp(int newHp);
  bool _bossWarned = false;
  bool get bossWarned => _bossWarned;

  void start();
  void pauseAttack();
  void stopAttack();
  void die();

  Future<void> warn() async {
    final warning = SpriteComponent(
      sprite: await Sprite.load('BOSSFIGHT.png'),
      position: game.grid.size / 2,
      size: game.grid.size / 2,
      anchor: Anchor.center,
      scale: Vector2.all(0),
    );
    game.grid.add(warning
      ..add(SequenceEffect([
        ScaleEffect.to(
            Vector2.all(1),
            EffectController(
              duration: 0.5,
            )),
        ScaleEffect.to(
            Vector2.all(1.2),
            EffectController(
              repeatCount: 3,
              duration: 0.3,
              reverseDuration: 0.3,
            )),
        ScaleEffect.to(Vector2.all(0), EffectController(duration: 0.5)),
      ], onComplete: () {
        game.grid.remove(warning);
        _bossWarned = true;
        game.grid.controlTurnedOff = false;
      })));
  }

  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.center;
    gameRef.camera.viewfinder.add(BossHp(boss: this)
      ..position = Vector2(gameRef.size.x / 2 - hp * 48 / 2, 16));
    return super.onLoad();
  }
}
