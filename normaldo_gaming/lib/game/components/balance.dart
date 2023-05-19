import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';

class Balance extends SpriteComponent
    with FlameBlocListenable<GameSessionCubit, GameSessionState> {
  Balance()
      : super(
          size: Vector2.all(30),
        );

  final _amountLabel = TextComponent(
      text: '0',
      textRenderer: TextPaint(
          style: NGTheme.displayMedium.copyWith(
        background: Paint()
          ..color = BasicPalette.black.color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50.0),
      )));

  @override
  void onNewState(GameSessionState state) {
    _amountLabel.text = state.dollars.toString();
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('dollar.png');
    _amountLabel.x = 38;

    add(_amountLabel);
  }
}
