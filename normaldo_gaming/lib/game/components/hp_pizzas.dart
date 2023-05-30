import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';

enum PizzaPack { one, two, three }

class HpPizzas extends SpriteGroupComponent<PizzaPack>
    with FlameBlocListenable<GameSessionCubit, GameSessionState> {
  static const disabledOpacity = 0.3;

  HpPizzas() : super(size: Vector2(40, 40));

  late final Sprite _onePizzaSprite;
  late final Sprite _twoPizzaSprite;
  late final Sprite _threePizzaSprite;

  @override
  bool listenWhen(GameSessionState previousState, GameSessionState newState) {
    return previousState.lives != newState.lives;
  }

  @override
  void onNewState(GameSessionState state) {
    switch (state.lives) {
      case 0:
        current = PizzaPack.one;
        opacity = disabledOpacity;
        break;
      case 1:
        current = PizzaPack.one;
        opacity = disabledOpacity;

        break;
      case 2:
        current = PizzaPack.one;
        opacity = 1;
        break;
      case 3:
        current = PizzaPack.two;
        opacity = 1;
        break;
      case 4:
        current = PizzaPack.three;
        opacity = 1;
        break;
      default:
        throw UnexpectedError();
    }
  }

  @override
  FutureOr<void> onLoad() async {
    _onePizzaSprite = await Sprite.load('pizza_pack1.png');
    _twoPizzaSprite = await Sprite.load('pizza_pack2.png');
    _threePizzaSprite = await Sprite.load('pizza_pack3.png');

    sprites = {
      PizzaPack.one: _onePizzaSprite,
      PizzaPack.two: _twoPizzaSprite,
      PizzaPack.three: _threePizzaSprite,
    };

    current = PizzaPack.one;
    opacity = disabledOpacity;
  }
}
