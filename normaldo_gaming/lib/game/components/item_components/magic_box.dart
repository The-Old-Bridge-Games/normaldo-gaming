import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/core/roller/roller.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/item_components/banana_peel.dart';
import 'package:normaldo_gaming/game/components/item_components/beer.dart';
import 'package:normaldo_gaming/game/components/item_components/casey_mask.dart';
import 'package:normaldo_gaming/game/components/item_components/cocktail.dart';
import 'package:normaldo_gaming/game/components/item_components/dollar.dart';
import 'package:normaldo_gaming/game/components/item_components/girl.dart';
import 'package:normaldo_gaming/game/components/item_components/gold_clocks.dart';
import 'package:normaldo_gaming/game/components/item_components/green_poison.dart';
import 'package:normaldo_gaming/game/components/item_components/hourglass.dart';
import 'package:normaldo_gaming/game/components/item_components/magic_hat.dart';
import 'package:normaldo_gaming/game/components/item_components/money_bag.dart';
import 'package:normaldo_gaming/game/components/item_components/pizza.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class MagicBox extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item, CustomEffectItem {
  @override
  ShapeHitbox get hitbox => CircleHitbox.relative(
        0.8,
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.magicBox;

  var _animationInProgress = false;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      applyEffect(() {
        collidable = false;
        _animationInProgress = true;
        final grid = game.grid;
        grid.removeAllItems(exclude: [this]);
        grid.stopAllLines();
        List<Vector2> takenPos = [];
        final lineAllocation = grid.lineXAllocation(size.x);
        add(
          ScaleEffect.to(
              Vector2.all(0),
              EffectController(
                duration: 0.2,
                reverseDuration: 0.2,
              ), onComplete: () {
            add(TimerComponent(
                period: 0.2,
                repeat: true,
                onTick: () {
                  if (!_animationInProgress) return;
                  Vector2 getPos() {
                    if (lineAllocation.isEmpty) {
                      lineAllocation.addAll(grid.lineXAllocation(size.x));
                    }
                    final xPos =
                        lineAllocation[Random().nextInt(lineAllocation.length)];
                    final pos = Vector2(
                      xPos,
                      grid.linesCentersY[
                          Random().nextInt(grid.linesCentersY.length)],
                    );
                    if (takenPos.isNotEmpty && takenPos.last.y == pos.y) {
                      return getPos();
                    }
                    lineAllocation.remove(xPos);
                    takenPos.add(pos);
                    return pos;
                  }

                  final pos = getPos();
                  final roller = Roller<Item>([
                    (Pizza(), 5),
                    (PurpleCocktail(), 1),
                    (GreenPoison(), 1),
                    (Girl(), 1),
                    (BananaPeel(), 1),
                    (Beer(), 1),
                    (MoneyBag(), 0.1),
                    (CaseyMask(), 0.5),
                    (Dollar(), 2),
                    (MagicHat(), 0.5),
                    (Hourglass(), 0.5),
                    (GoldClocks(), 0.5),
                  ]);
                  final item = roller.roll()..collidable = false;
                  grid.add(item
                    ..size = item.item.getSize(grid.lineSize)
                    ..position = Vector2(
                        grid.normaldo.position.x + 10,
                        grid.normaldo.position.y -
                            grid.normaldo.size.y / 2 -
                            size.y / 2)
                    ..add(MoveToEffect(
                      pos,
                      EffectController(
                        speed: 1000,
                        onMax: () {
                          item.collidable = true;
                        },
                      ),
                    )));
                }));
            grid.add(TimerComponent(
              removeOnFinish: true,
              period: 0.2 * 8,
              onTick: () {
                _animationInProgress = false;
                add(ScaleEffect.to(
                    Vector2.all(0),
                    EffectController(
                      duration: 0.2,
                    )));
                grid.add(TimerComponent(
                    period: 2,
                    removeOnFinish: true,
                    onTick: () {
                      grid.resumeLines();
                      removeFromParent();
                    }));
              },
            ));
          }),
        );
      });
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('magic box 2.png');
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (_animationInProgress) {
      final normaldo = game.grid.normaldo;
      position.x = normaldo.position.x + 10;
      position.y = normaldo.position.y - normaldo.size.y / 2 - size.y / 2;
    }
    super.update(dt);
  }
}
