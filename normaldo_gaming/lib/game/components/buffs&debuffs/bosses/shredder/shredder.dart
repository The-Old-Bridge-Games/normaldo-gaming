import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/attacks/predator_attack.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/attacks/shredder_attack.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/attacks/shuriken_shower_attack.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Shredder extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Shredder() : super(anchor: Anchor.center);

  late final eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  final List<ShredderAttack> _attacks = [];

  late final SpriteComponent shredderSprite;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    if (!hearsBloc) return;
    speed = state.level.speed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && !other.immortal) {
      other.takeHit();
      audio.playSfx(Sfx.binCrash);
      // attack =
    }
    if (other is GameObject && !disabled) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    autoRemove = false;
    onRemoved = () {
      bloc.add(const LevelEvent.finishMiniGame());
      bloc.add(
          const LevelEvent.startFigure(figure: FigureEvent.winMoneyLabel()));
    };
    disabled = true;
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    shredderSprite = SpriteComponent(
      size: size,
      sprite: await Sprite.load('shredder.png'),
    );
    add(shredderSprite);

    add(eatingHitbox);

    final grid = (gameRef as PullUpGame).grid;
    _attacks.addAll([
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
      ShurikenShowerAttack(),
      PredatorAttack(),
      PredatorAttack(),
      PredatorAttack(),
      PredatorAttack(),
      PredatorAttack(),
      PredatorAttack(),
    ]);
    _attacks.shuffle();
    if (_attacks.isNotEmpty) {
      _attacks.first.start(this, grid);
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_attacks.isNotEmpty) {
      if (_attacks.first.completed) {
        _attacks.removeAt(0);
        if (_attacks.isNotEmpty) {
          _attacks.first.start(this, (gameRef as PullUpGame).grid);
        }
      }
    } else {
      removeFromParent();
    }
  }

  @override
  bool get isSoloSpawn => true;

  @override
  Items get item => Items.shredder;
}
