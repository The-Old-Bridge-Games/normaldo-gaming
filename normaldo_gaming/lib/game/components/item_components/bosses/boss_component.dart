import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/attacks/boss_attack.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

mixin Boss on PositionComponent, HasGameRef<PullUpGame>, CollisionCallbacks {
  int get hp;
  set hp(int newHp);
  bool _bossWarned = false;
  bool get bossWarned => _bossWarned;
  List<BossAttack> attacks = [];
  List<Items> immuneToItems = [];

  void start();
  void die();

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      other.takeHit();
    }
    if (other is Item && !immuneToItems.contains(other.item)) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

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

    return super.onLoad();
  }
}
