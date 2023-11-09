import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class PullUpGameOnboarding1 extends FlameGame with HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    final fingerPos = normaldoPos + Vector2(-size.x / 3, 0);
    final finger = SpriteComponent(
      size: Vector2.all(30),
      sprite: await Sprite.load('finger.png'),
    )..position = fingerPos;
    final normaldo = Normaldo(size: Vector2.all(60))..position = normaldoPos;
    await add(FlameBlocProvider<GameSessionCubit, GameSessionState>(
        create: () => injector.get(),
        children: [
          normaldo,
          finger,
          TextComponent(
            text: 'your finger',
            textRenderer: TextPaint(
              style: NGTheme.displaySmall,
            ),
          )
            ..size = Vector2(100, 30)
            ..position = fingerPos + Vector2(-50, 40)
            ..add(RemoveEffect(
              delay: 2,
            )),
          TimerComponent(
              period: 2,
              removeOnFinish: true,
              onTick: () {
                add(
                  TextComponent(
                    text: 'hold..',
                    textRenderer: TextPaint(
                      style: NGTheme.displaySmall,
                    ),
                  )
                    ..position = fingerPos + Vector2(-20, -30)
                    ..add(RemoveEffect(
                      delay: 2,
                    )),
                );
              }),
        ]));
    finger.add(SequenceEffect([
      ScaleEffect.to(
          Vector2.all(0.8),
          EffectController(
            startDelay: 2,
            duration: 1,
          ))
    ]));
    final controller = EffectController(
      duration: 2,
      startDelay: 8,
    );
    normaldo.add(MoveByEffect(Vector2(100, 0), controller));
    finger.add(MoveEffect.by(Vector2(50, 0), controller));
    return super.onLoad();
  }
}
