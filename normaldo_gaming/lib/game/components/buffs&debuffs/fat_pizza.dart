import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/pizza.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class FatPizza extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  FatPizza() : super(anchor: Anchor.center);

  @override
  Aura get aura => Aura.green;

  @override
  Component get auraComponent => PolygonComponent(
        [
          Vector2(size.x * 0.3, 0), // top point
          Vector2(size.x, size.y * 0.3), // right point
          Vector2(size.x * 0.7, size.y), // bottom point
          Vector2(0, size.y * 0.5), // left point
        ],
        size: size * 1.2,
        paint: auraPaint,
      );

  bool _active = false;

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
    if (_active) return;
    if (other is Normaldo) {
      final grid = (gameRef as PullUpGame).grid;
      grid.removeAllItems(exclude: [this]);
      List<Vector2> takenPos = [];
      final lineAllocation = grid.lineXAllocation(size.x);
      add(ScaleEffect.to(
          Vector2(0, 0),
          EffectController(
            duration: 0.2,
            reverseDuration: 0.2,
            onMax: () {
              _active = true;
              add(TimerComponent(
                  period: 0.1,
                  repeat: true,
                  onTick: () {
                    Vector2 getPos() {
                      final pos = Vector2(
                        lineAllocation[Random()
                            .nextInt(grid.lineXAllocation(size.x).length)],
                        grid.linesCentersY[
                            Random().nextInt(grid.linesCentersY.length)],
                      );
                      if (takenPos.any((e) => e == pos)) return getPos();
                      takenPos.add(pos);
                      return pos;
                    }

                    final pos = getPos();
                    final pizza = Pizza()
                      ..eatingHitbox.collisionType = CollisionType.active;
                    grid.add(pizza
                      ..disabled = true
                      ..size = Items.pizza.getSize(grid.lineSize)
                      ..position = Vector2(
                          grid.normaldo.position.x + 10,
                          grid.normaldo.position.y -
                              grid.normaldo.size.y / 2 -
                              size.y / 2)
                      ..add(MoveToEffect(
                        pos,
                        EffectController(
                          speed: 1000,
                          onMax: () => pizza.disabled = false,
                        ),
                      )));
                  }));
              Future.delayed(Duration(seconds: 3 + Random().nextInt(4)))
                  .whenComplete(() => removeFromParent());
            },
          )));
      audio.playSfx(Sfx.eatFatPizza);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('pizza_pack1.png'),
    ));
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    add(ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(
          infinite: true,
          duration: 0.3,
          reverseDuration: 0.3,
        )));

    return super.onLoad();
  }

  @override
  bool get isSoloSpawn => true;

  @override
  void update(double dt) {
    if (_active) {
      final normaldo = (gameRef as PullUpGame).grid.normaldo;
      position.x = normaldo.position.x + 10;
      position.y = normaldo.position.y - normaldo.size.y / 2 - size.y / 2;
    }
    super.update(dt);
  }
}
