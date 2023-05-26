import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';

class ScoreLabel extends PositionComponent
    with FlameBlocListenable<GameSessionCubit, GameSessionState> {
  ScoreLabel()
      : super(
          position: Vector2(48, 16),
          anchor: Anchor.topLeft,
        );

  final _text = TextComponent(
      textRenderer: TextPaint(
          style: NGTheme.displayMedium.copyWith(
    background: Paint()
      ..color = BasicPalette.black.color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50.0),
  )));

  @override
  FutureOr<void> onLoad() async {
    final pizzaSprite = SpriteComponent(
      sprite: await Sprite.load('pizza1.png'),
      size: Vector2.all(25),
    );
    add(pizzaSprite..position.y = 4);
    _text.text = '0';
    add(_text..position.x = pizzaSprite.size.x + 12);
  }

  @override
  void onNewState(GameSessionState state) {
    _text.text = state.score.toString();
  }
}
