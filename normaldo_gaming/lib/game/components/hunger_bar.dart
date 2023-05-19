import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/components/rounded_rectangle_component.dart';
import 'package:normaldo_gaming/core/theme.dart';

class HungerBar extends PositionComponent
    with
        FlameBlocListenable<GameSessionCubit, GameSessionState>,
        FlameBlocReader<GameSessionCubit, GameSessionState> {
  final livesComponent = TextComponent(
      text: GameSessionCubit.initialLivesCount.toString(),
      textRenderer: TextPaint(
          style: NGTheme.displayMedium.copyWith(
        background: Paint()
          ..color = BasicPalette.black.color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50.0),
      )));

  @override
  void onNewState(GameSessionState state) {
    livesComponent.text = state.lives.toString();
  }

  @override
  Future<void> onLoad() async {
    final pizzaSprite = SpriteComponent(
      sprite: await Sprite.load('pizza_lives.png'),
      size: Vector2.all(30),
    );
    add(pizzaSprite..y = livesComponent.y + 4);
    add(livesComponent
      ..position = Vector2(pizzaSprite.width + 16, livesComponent.y));
    add(_Bar(
      onHungerDropped: () {
        bloc.takeLife();
      },
    )..position = Vector2(
        livesComponent.x + livesComponent.size.x + 8, livesComponent.y + 12));
    return super.onLoad();
  }
}

class _Bar extends RoundedRectangleComponent {
  _Bar({
    required this.onHungerDropped,
  }) : super(
          radius: const Radius.circular(3),
          size: Vector2(200, 16),
          paint: Paint()..color = BasicPalette.orange.color,
        );

  final VoidCallback onHungerDropped;

  @override
  FutureOr<void> onLoad() {
    add(RoundedRectangleComponent(
      radius: const Radius.circular(3),
      size: size,
      paint: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = BasicPalette.orange.color,
    ));
    add(TimerComponent(
        period: 0.02,
        autoStart: true,
        repeat: true,
        onTick: () {
          if (size.x == 0) {
            onHungerDropped();
            size.x = 200;
          }
          size.x -= 1;
        }));
  }
}
