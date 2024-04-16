import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class Policeman extends PositionComponent
    with HasGameRef<PullUpGame>, CollisionCallbacks, Item, AttackingItem {
  Policeman({this.called = false});
  @override
  Items get item => Items.policeman;

  @override
  int get damage => 1;

  @override
  ShapeHitbox get hitbox => CircleHitbox.relative(
        0.9,
        parentSize: size,
        anchor: anchor,
      );

  late final SpriteComponent _hand;
  late final SpriteComponent _policeman;

  // if this policeman was called by another so this one wouldn't call another one
  final bool called;

  bool _gotHelp = false;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    attack(other);
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    strength = 1;
    final sprite = await Sprite.load('policeman.png');
    add(_policeman = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: anchor,
      position: size / 2,
    ));
    _hand = SpriteComponent(
        sprite: await Sprite.load('policeman_calling.png'),
        anchor: anchor,
        scale: Vector2.all(0),
        size: Vector2(size.x * 0.6, size.y * 0.8));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (position.x < game.grid.size.x && !_gotHelp && !called) {
      _gotHelp = true;
      _getHelp();
    }
    super.update(dt);
  }

  void _getHelp() {
    add(_hand
      ..position = Vector2(size.x * 0.8, size.y / 1.5)
      ..add(ScaleEffect.to(
          Vector2.all(1),
          EffectController(
            duration: 0.3,
            atMaxDuration: 1,
            reverseDuration: 0.3,
          ), onComplete: () {
        remove(_hand);
      })));
    _policeman.addAll([
      RotateEffect.by(
          0.05 * (Random().nextBool() ? 1 : -1),
          EffectController(
            duration: 0.1,
            reverseDuration: 0.1,
            infinite: true,
            startDelay: 0.3,
          )),
      TimerComponent(
          period: 1,
          removeOnFinish: true,
          onTick: () {
            _policeman.removeWhere((component) => component is RotateEffect);
            _policeman.angle = 0;
            final yCenters = game.grid.linesCentersY;
            final currentCenterIndex = yCenters.indexOf(position.y);
            final yPos = switch (currentCenterIndex) {
              0 => yCenters[1],
              1 =>
                yCenters[currentCenterIndex + (Random().nextBool() ? 1 : -1)],
              2 =>
                yCenters[currentCenterIndex + (Random().nextBool() ? 1 : -1)],
              3 =>
                yCenters[currentCenterIndex + (Random().nextBool() ? 1 : -1)],
              4 => yCenters[3],
              _ => throw UnexpectedError(),
            };
            final newPoliceman = Policeman()..collidable = false;
            collidable = false;
            game.grid.add(
              newPoliceman
                ..size = size
                ..position = position
                ..scale = Vector2.all(0)
                ..addAll([
                  ScaleEffect.to(
                      Vector2.all(1),
                      EffectController(
                        duration: 0.3,
                      )),
                  RotateEffect.by(
                      pi * 2,
                      EffectController(
                        duration: 0.3,
                      )),
                  MoveEffect.to(
                    Vector2(position.x, yPos),
                    EffectController(
                      duration: 0.3,
                    ),
                    onComplete: () {
                      newPoliceman.collidable = true;
                      collidable = true;
                    },
                  )
                ]),
            );
          })
    ]);
  }
}
