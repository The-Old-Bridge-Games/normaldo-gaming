import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';

enum NormaldoState {
  idle,
  hit,
}

class Normaldo extends SpriteComponent
    with FlameBlocReader<GameSessionCubit, GameSessionState>, _StateActions {
  Normaldo({
    required Vector2 size,
  }) : super(size: size);

  bool _immortal = false;

  var _state = NormaldoState.idle;

  set state(NormaldoState newState) {
    switch (newState) {
      case NormaldoState.idle:
        _immortal = false;
        _stopFlick();
        break;
      case NormaldoState.hit:
        _immortal = true;
        _startFlick();
        break;
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('normaldo1.png');
    add(RectangleHitbox());

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) => prevState.hit != newState.hit,
        onNewState: (cState) {
          state = cState.hit ? NormaldoState.hit : NormaldoState.idle;
        }));
  }
}

mixin _StateActions on SpriteComponent {
  Future<void> _startFlick() async {
    final controller = EffectController(
      duration: 0.1,
      reverseDuration: 0.1,
      infinite: true,
    );
    add(OpacityEffect.to(0, controller));
  }

  Future<void> _stopFlick() async {
    opacity = 1;
    removeWhere((component) => component is OpacityEffect);
  }
}
