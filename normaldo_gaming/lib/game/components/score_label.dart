import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';

class ScoreLabel extends TextComponent
    with FlameBlocListenable<GameSessionCubit, GameSessionState> {
  ScoreLabel()
      : super(
          position: NotifyingVector2(48, 16),
          text: 'score: 0',
          anchor: Anchor.topLeft,
          textRenderer: TextPaint(
              style: NGTheme.displayMedium.copyWith(
            background: Paint()
              ..color = BasicPalette.black.color
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50.0),
          )),
        );

  @override
  void onNewState(GameSessionState state) {
    text = 'score: ${state.score.toString()}';
  }
}
