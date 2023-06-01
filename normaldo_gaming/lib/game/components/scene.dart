import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/levels.dart';

class Scene extends PositionComponent with HasGameRef {
  Scene({required this.initialSize});

  final Vector2 initialSize;

  @override
  Future<void> onLoad() async {
    final _paint = Paint()..color = Colors.black.withOpacity(0.05);
    addAll([
      SpriteComponent(
        sprite: await Sprite.load('backgrounds/bg0.png'),
      )
        ..position = position
        ..size = size,
      SpriteComponent(
        sprite: await Sprite.load('backgrounds/bg1.png'),
      )
        ..position = Vector2(size.x, y)
        ..size = size,
      RectangleComponent(
        size: size * 2,
        paint: _paint,
      ),
    ]);
    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
      listenWhen: (previousState, newState) =>
          previousState.level != newState.level,
      onNewState: (state) async {
        final level = state.level;
        add(
          SpriteComponent(
            sprite: await Sprite.load(
                'backgrounds/bg${(state.level + 1) % 22}.png'),
          )
            ..position = Vector2(initialSize.x * (level + 1), y)
            ..size = size,
        );
        add(RectangleComponent(
          size: size,
          paint: _paint,
          position: Vector2(initialSize.x * (level + 1), y),
        ));
        _move(level: level);
      },
    ));

    _move(level: 0);
    super.onLoad();
  }

  void _move({required int level}) {
    add(MoveToEffect(
        Vector2(-initialSize.x * (level + 1), 0),
        EffectController(
          duration: Levels.levelChangeSeconds,
        )));
  }
}
