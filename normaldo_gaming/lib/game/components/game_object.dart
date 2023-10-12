import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/injection/injection.dart';

mixin GameObject on PositionComponent, HasGameRef, CollisionCallbacks {
  final _levelManager = injector.get<LevelManager>();

  double speed = 0.0;
  bool hearsBloc = true;
  void Function() onRemoved = () {};

  bool disabled = false;

  Items get item;

  bool get isSoloSpawn;

  NgAudio get audio => injector.get();

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo && !other.immortal) {
      _levelManager.checkHit(hitItem: item);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  @mustCallSuper
  void update(double dt) {
    if (!disabled) {
      position.x -= speed * dt;
    }
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void removeFromParent() {
    if (parent is FlameBlocProvider) {
      parent?.removeFromParent();
    }
    super.removeFromParent();
  }

  @override
  void onRemove() {
    onRemoved();
    super.onRemove();
  }
}

extension on Aura {
  Color get color {
    switch (this) {
      case Aura.blue:
        return NGTheme.auraBlue;
      case Aura.green:
        return NGTheme.auraGreen;
      case Aura.red:
        return NGTheme.auraRed;
    }
  }
}
