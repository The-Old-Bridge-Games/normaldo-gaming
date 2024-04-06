import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

import 'package:normaldo_gaming/game/components/effects/effects.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/ninja_foot/smoke.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/attacks/predator_attack.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/attacks/shuriken_shower_attack.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/smoke_attack.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

enum NinjaFootState {
  idle,
  predator,
  predator2,
  smoke,
}

final class NinjaFoot extends SpriteAnimationGroupComponent<NinjaFootState>
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
    const double moveFromRightSideDur = 1;
    final grid = game.grid;
    scale = Vector2.all(4);
    // Move boss from outside of screen to the right side
    addAll([
      MoveEffect.to(
          Vector2(grid.size.x - size.x / 2, grid.size.y / 2),
          EffectController(
            duration: moveFromRightSideDur,
          ), onComplete: () {
        // Normaldo takes his position when boss talking
        if (grid.normaldo.position != grid.center) {
          grid.normaldo.addAll(jumpToEffect(
            position: grid.center,
          ));
        }
      }),
      // Boss shaking when moving and camera zooming in
      RotateEffect.by(
          0.05,
          EffectController(
            repeatCount: moveFromRightSideDur.toInt(),
            duration: 1,
            reverseDuration: 1,
          ), onComplete: () {
        // Boss shaking his head when talking
        add(RotateEffect.by(
            0.05,
            EffectController(
              repeatCount: 1,
              duration: 0.4,
              reverseDuration: 1,
            ), onComplete: () {
          // boss warning
          warn();
          // boss moving backwards
          add(MoveByEffect(
            Vector2(size.x * 3, 0),
            EffectController(duration: moveFromRightSideDur),
          ));
          game.camera.moveTo(game.size / 2, speed: 500);
          game.camera.viewfinder.add(ScaleEffect.to(
              Vector2.all(1),
              EffectController(
                duration: 0.5,
              )));
        }));
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
      } else {
        gameRef.grid.resumeLines();
        print('speed: ' + gameRef.levelBloc.state.level.speed.toString());
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
      case NinjaFootState.smoke:
        size = Vector2(game.grid.lineSize * 2, game.grid.lineSize);
      default:
        break;
    }
    children.whereType<RectangleHitbox>().forEach((element) {
      element.size = size * 0.9;
    });
    super.current = value;
  }

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(game.grid.lineSize * 0.755, game.grid.lineSize);
    final idleSprite = await Sprite.load('bosses/ninja foot1.png');
    final predatorSprite = await Sprite.load('bosses/ninja_foot_predator2.png');
    final predator2Sprite = await Sprite.load('bosses/ninja_foot_predator.png');
    final smokeAnimation = SpriteAnimation.fromFrameData(
      await Flame.images.load('bosses/ninja_foot_smoke.png'),
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.2,
        textureSize: Vector2(426, 245),
        loop: false,
      ),
    );
    animations = {
      NinjaFootState.idle: SpriteAnimation.spriteList(
        [idleSprite],
        stepTime: 5,
      ),
      NinjaFootState.predator:
          SpriteAnimation.spriteList([predatorSprite], stepTime: 5),
      NinjaFootState.predator2:
          SpriteAnimation.spriteList([predator2Sprite], stepTime: 5),
      NinjaFootState.smoke: smokeAnimation
    };
    current = NinjaFootState.idle;
    add(RectangleHitbox.relative(
      Vector2.all(0.8),
      parentSize: size,
      anchor: anchor,
    ));
    attacks = [
      ShurikenShowerAttack(speed: 500, endDelay: 1),
      ShurikenShowerAttack(speed: 500, endDelay: 1),
      PredatorAttack(speed: 600),
      PredatorAttack(speed: 600),
      ShurikenShowerAttack(speed: 700, endDelay: 1),
      ShurikenShowerAttack(speed: 700, endDelay: 1),
      PredatorAttack(speed: 700),
      PredatorAttack(speed: 700),
      ShurikenShowerAttack(speed: 700),
      PredatorAttack(speed: 700),
      SmokeAttack(duration: 15, action: SmokeAction.corners),
      ShurikenShowerAttack(speed: 700, endDelay: 1),
      ShurikenShowerAttack(speed: 700, endDelay: 1),
      PredatorAttack(speed: 700),
      PredatorAttack(speed: 700),
      ShurikenShowerAttack(speed: 700, endDelay: 1),
      ShurikenShowerAttack(speed: 700, endDelay: 1),
      PredatorAttack(speed: 700),
      PredatorAttack(speed: 700),
      ShurikenShowerAttack(speed: 700),
      PredatorAttack(speed: 700),
      SmokeAttack(action: SmokeAction.fullScreen),
      // ShurikenShowerAttack(speed: 500, endDelay: 1),
      // ShurikenShowerAttack(speed: 500, endDelay: 1),
      // ShurikenShowerAttack(speed: 500, endDelay: 1),
      // PredatorAttack(speed: 500),
      // PredatorAttack(speed: 500),
      // PredatorAttack(speed: 500),
      // ShurikenShowerAttack(speed: 500),
      // PredatorAttack(speed: 500),
      // ShurikenShowerAttack(speed: 500),
      // PredatorAttack(speed: 500),
      // SmokeAttack(),
      // ShurikenShowerAttack(speed: 800),
      // ShurikenShowerAttack(speed: 800),
      // ShurikenShowerAttack(speed: 800),
      // ShurikenShowerAttack(speed: 800),
      // ShurikenShowerAttack(speed: 800),
      // PredatorAttack(speed: 800),
      // PredatorAttack(speed: 800),
      // PredatorAttack(speed: 800),
      // PredatorAttack(speed: 800),
      // PredatorAttack(speed: 800),
      // ShurikenShowerAttack(speed: 800),
      // PredatorAttack(speed: 900),
      // ShurikenShowerAttack(speed: 800),
      // PredatorAttack(speed: 900),
      // ShurikenShowerAttack(speed: 800),
      // PredatorAttack(speed: 900),
      // ShurikenShowerAttack(speed: 900),
      // PredatorAttack(speed: 1000),
    ];
    return super.onLoad();
  }

  @override
  void die() {
    print('ninja foot died');
  }
}
