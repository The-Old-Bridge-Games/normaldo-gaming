import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

import 'package:normaldo_gaming/game/components/effects/effects.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/attacks/predator_attack.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/attacks/shuriken_shower_attack.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

enum NinjaFootState {
  idle,
  predator,
  predator2,
}

final class NinjaFoot extends SpriteGroupComponent<NinjaFootState>
    with HasGameRef<PullUpGame>, CollisionCallbacks, Boss, Effects {
  NinjaFoot() {
    debugMode = false;
  }

  @override
  List<Items> get immuneToItems => [Items.shuriken];

  @override
  int hp = 3;

  @override
  void start() {
    const double moveFromRightSideDur = 3;
    final grid = game.grid;
    // Move boss from outside of screen to the right side
    addAll([
      MoveEffect.to(
          Vector2(grid.size.x - size.x * 2, grid.size.y / 2),
          EffectController(
            duration: moveFromRightSideDur,
          ), onComplete: () {
        // Normaldo takes his position when boss talking
        if (grid.normaldo.position !=
            Vector2(position.x - size.x * 5, position.y)) {
          grid.normaldo.addAll(jumpToEffect(
            position: Vector2(position.x - size.x * 4.5, position.y),
          ));
        }
      }),
      // Boss shaking when moving and camera zooming in
      RotateEffect.by(
          0.05,
          EffectController(
            repeatCount: moveFromRightSideDur.toInt(),
            duration: 0.5,
            reverseDuration: 0.5,
          ), onComplete: () {
        game.camera.viewfinder.add(ScaleEffect.to(
            Vector2.all(2),
            EffectController(
              duration: 1,
            ), onComplete: () {
          // Boss shaking his head when talking
          add(RotateEffect.by(
              0.05,
              EffectController(
                repeatCount: 1,
                duration: 0.2,
                reverseDuration: 0.5,
              ), onComplete: () {
            // boss warning
            warn();
            grid.normaldo.addAll(jumpToEffect(
              position: Vector2(grid.normaldo.size.x, position.y),
            ));
            add(fadeOutEffect());
            game.camera.moveTo(game.size / 2, speed: 500);
            game.camera.viewfinder.add(ScaleEffect.to(
                Vector2.all(1),
                EffectController(
                  duration: 0.5,
                )));
          }));
        }));
        game.camera.moveTo(
          Vector2(position.x - size.x * 2, position.y),
          speed: 300,
        );
      })
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (bossWarned) {
      if (opacity == 0) {
        opacity = 1;
      }
      if (attacks.isNotEmpty) {
        if (attacks.first.completed) {
          attacks.removeAt(0);
          if (attacks.isNotEmpty) {
            attacks.first.start(this, gameRef.grid);
          }
        } else if (!attacks.first.inProgress) {
          attacks.first.start(this, gameRef.grid);
        }
      }
    }
  }

  @override
  set current(NinjaFootState? value) {
    switch (value) {
      case NinjaFootState.idle:
        size = Vector2(game.grid.lineSize * 0.755, game.grid.lineSize);
      case NinjaFootState.predator:
        size = Vector2(game.grid.lineSize * 2, game.grid.lineSize * 1.5);
      case NinjaFootState.predator2:
        size = Vector2(game.grid.lineSize * 2, game.grid.lineSize * 1.5);
      default:
        break;
    }
    super.current = value;
  }

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(game.grid.lineSize * 0.755, game.grid.lineSize);
    sprites = {
      NinjaFootState.idle: await Sprite.load('bosses/ninja foot1.png'),
      NinjaFootState.predator:
          await Sprite.load('bosses/ninja_foot_predator2.png'),
      NinjaFootState.predator2:
          await Sprite.load('bosses/ninja_foot_predator.png'),
    };
    current = NinjaFootState.idle;
    add(RectangleHitbox());
    attacks = [
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
      PredatorAttack(),
      PredatorAttack(),
      PredatorAttack(),
      PredatorAttack(),
      ShurikenShowerAttack(),
      PredatorAttack(),
      ShurikenShowerAttack(),
      PredatorAttack(),
      ShurikenShowerAttack(),
      PredatorAttack(),
    ];
    return super.onLoad();
  }

  @override
  void die() {
    print('ninja foot died');
  }
}
