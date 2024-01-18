import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
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
    final normaldo = Normaldo(size: Vector2.all(60), skin: Skin.basic())
      ..position = normaldoPos;
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameSessionCubit, GameSessionState>(
            create: () => injector.get(),
          ),
          FlameBlocProvider<LevelBloc, LevelState>(
            create: () => injector.get(),
          ),
        ],
        children: [
          normaldo,
          finger,
        ],
      ),
    );
    start(normaldo, finger);
    return super.onLoad();
  }

  void start(Normaldo normaldo, SpriteComponent finger) {
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    final fingerPos = normaldoPos + Vector2(-size.x / 3, 0);
    normaldo.removeWhere((component) => component is Effect);
    finger.removeWhere((component) => component is Effect);
    normaldo.position = normaldoPos;
    finger.position = fingerPos;
    finger.add(SequenceEffect([
      ScaleEffect.to(
          Vector2.all(1),
          EffectController(
            duration: 0.5,
          ))
    ]));
    finger.addAll([
      TextComponent(
        text: 'hold&drag',
        textRenderer: TextPaint(
          style: NGTheme.displaySmall,
        ),
      )
        ..position = Vector2(-30, -30)
        ..add(RemoveEffect(
          delay: 6,
        )),
    ]);
    finger.add(SequenceEffect([
      ScaleEffect.to(
          Vector2.all(0.8),
          EffectController(
            startDelay: 1,
            duration: 0.5,
          ))
    ]));
    EffectController controller({
      double startDelay = 0.0,
    }) =>
        EffectController(
          speed: 100,
          startDelay: startDelay,
        );
    normaldo.add(SequenceEffect([
      MoveByEffect(Vector2(100, 0), (controller(startDelay: 2))),
      MoveByEffect(Vector2(-30, -40), controller()),
      MoveByEffect(Vector2(-30, 80), controller()),
      MoveByEffect(Vector2(-40, -40), controller()),
    ]));
    finger.add(SequenceEffect([
      MoveEffect.by(Vector2(100, 0), controller(startDelay: 2)),
      MoveByEffect(Vector2(-30, -40), controller()),
      MoveByEffect(Vector2(-30, 80), controller()),
      MoveByEffect(Vector2(-40, -40), controller(), onComplete: () {
        start(normaldo, finger);
      }),
    ]));
  }
}
