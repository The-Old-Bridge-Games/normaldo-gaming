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
  late final _Bar _bar;

  void restoreBar() {
    _bar.size.x = 200;
  }

  @override
  void onNewState(GameSessionState state) {
    livesComponent.text = state.lives.toString();
  }

  @override
  Future<void> onLoad() async {
    _bar = _Bar(
      onHungerDropped: () => bloc.decreaseHunger(),
    );
    final pizzaSprite = SpriteComponent(
      sprite: await Sprite.load('heart.png'),
      size: Vector2.all(30),
    );

    add(pizzaSprite..y = livesComponent.y + 4);
    add(livesComponent
      ..position = Vector2(pizzaSprite.width + 16, livesComponent.y));
    add(_bar
      ..position = Vector2(
          livesComponent.x + livesComponent.size.x + 8, livesComponent.y + 12));

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
      listenWhen: (previousState, newState) =>
          previousState.lives < newState.lives,
      onNewState: (_) {
        restoreBar();
      },
    ));
    return super.onLoad();
  }
}

class _Bar extends RoundedRectangleComponent {
  final _color = BasicPalette.red.color.brighten(0.2);

  _Bar({
    required this.onHungerDropped,
  }) : super(
          radius: const Radius.circular(3),
          size: Vector2(200, 16),
        );

  final VoidCallback onHungerDropped;

  @override
  FutureOr<void> onLoad() {
    paint = Paint()..color = _color;

    add(RoundedRectangleComponent(
      radius: const Radius.circular(3),
      size: size,
      paint: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _color,
    ));
    add(TimerComponent(
        period: 0.04,
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
