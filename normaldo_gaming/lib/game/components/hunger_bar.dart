import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/components/rounded_rectangle_component.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class HungerBar extends PositionComponent
    with
        FlameBlocListenable<GameSessionCubit, GameSessionState>,
        FlameBlocReader<GameSessionCubit, GameSessionState>,
        HasGameRef {
  /// in seconds
  static const shakeDuration = 0.01;

  final livesComponent = TextComponent(
      text: GameSessionCubit.initialLivesCount.toString(),
      textRenderer: TextPaint(
          style: NGTheme.displayMedium.copyWith(
        background: Paint()
          ..color = BasicPalette.black.color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50.0),
      )));
  late final _Bar _bar;
  late final SpriteComponent _fatPizzaSprite;
  bool _hurryingUp = false;

  void restoreBar() {
    _bar.setBarSize(200);
  }

  @override
  bool listenWhen(GameSessionState previousState, GameSessionState newState) {
    if (previousState.lives > newState.lives && newState.lives > 1) {
      restoreBar();
      _shake();
    }
    return previousState.lives != newState.lives;
  }

  @override
  void onNewState(GameSessionState state) {
    restoreBar();
    if (state.lives == 0) {
      _bar.setBarSize(0);
    }
    livesComponent.text = state.lives.toString();
  }

  @override
  Future<void> onLoad() async {
    _bar = _Bar(
      onHungerDropped: () => bloc.decreaseHunger(),
      onLessThanHalfHP: (value) {
        final state = bloc.state;
        if (state.lives == 1 && value && !_hurryingUp) {
          _hurryingUp = true;
          _shake(infinite: true);
          _bar.startHurryingUp();
          (gameRef as PullUpGame).grid.normaldo.current =
              NormaldoFatState.skinny;
        } else if (state.lives == 1 && !value && _hurryingUp) {
          _hurryingUp = false;
          _bar.stopHurryingUp();
          stopShaking();
        }
        if (state.lives == 0) {
          _bar.setBarSize(0);
        }
      },
    );
    _fatPizzaSprite = SpriteComponent(
      sprite: await Sprite.load('fat_pizza.png'),
      size: Vector2.all(30),
      anchor: Anchor.center,
    );

    add(livesComponent
      ..position = Vector2(_fatPizzaSprite.width, livesComponent.y));
    add(_fatPizzaSprite..y = livesComponent.y + 20);
    add(_bar
      ..position = Vector2(
        livesComponent.x + livesComponent.size.x + livesComponent.size.x,
        livesComponent.size.y - _bar.size.y / 2 + 4,
      ));

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
      listenWhen: (previousState, newState) =>
          previousState.lives < newState.lives,
      onNewState: (_) {
        restoreBar();
      },
    ));
    return super.onLoad();
  }

  Future<void> _shake({bool infinite = false}) async {
    final controller = EffectController(
      infinite: true,
      duration: shakeDuration,
      reverseDuration: shakeDuration,
      // curve: Curves.linearToEaseOut,
    );
    _fatPizzaSprite.add(RotateEffect.to(
        pi * 0.1,
        EffectController(
          duration: shakeDuration,
        )));
    _fatPizzaSprite.add(RotateEffect.to(
      pi * -0.1,
      controller,
    ));
    if (infinite) return;
    Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
      stopShaking();
    });
  }

  void stopShaking() {
    _fatPizzaSprite.removeWhere(
      (component) => component is RotateEffect,
    );
    _fatPizzaSprite.add(RotateEffect.to(
        0,
        EffectController(
          duration: shakeDuration,
        )));
  }
}

class _Bar extends PositionComponent
    with FlameBlocReader<GameSessionCubit, GameSessionState> {
  final _color = BasicPalette.orange.color;

  _Bar({
    required this.onHungerDropped,
    required this.onLessThanHalfHP,
  }) : super(size: Vector2(200, 16), anchor: Anchor.centerLeft);

  final VoidCallback onHungerDropped;
  final void Function(bool) onLessThanHalfHP;

  final _bar = RoundedRectangleComponent(radius: const Radius.circular(3));
  final _border = RoundedRectangleComponent(
    radius: const Radius.circular(3),
    paint: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4,
  );
  final _hurryText = TextComponent(
    text: 'eat pizzzzza!!!!',
    textRenderer: TextPaint(style: NGTheme.bodySmall.copyWith(fontSize: 10)),
  );

  bool _lessThanHalfHP = false;

  void setBarSize(double x) {
    _bar.size.x = x;
  }

  @override
  Future<void> onLoad() async {
    final barSize = Vector2(200, 16);
    _bar.setColor(_color);
    _border.setColor(_color);
    add(
      _border
        ..size = barSize
        ..anchor = anchor,
    );
    add(
      _bar
        ..size = barSize
        ..anchor = anchor,
    );
    _hurryText.anchor = anchor;
    add(TimerComponent(
        period: 0.04,
        autoStart: true,
        repeat: true,
        onTick: () {
          if (_bar.size.x == 0) {
            onHungerDropped();
            _bar.size.x = 200;
          }
          _bar.size.x -= 1;
          if (_bar.size.x <= size.x / 2 && !_lessThanHalfHP) {
            _lessThanHalfHP = true;
            onLessThanHalfHP(_lessThanHalfHP);
          } else if (_bar.size.x > size.x / 2 && _lessThanHalfHP) {
            _lessThanHalfHP = false;
            onLessThanHalfHP(false);
          }
        }));

    return super.onLoad();
  }

  void startHurryingUp() {
    final targetScale = Vector2.all(1.2);
    add(_hurryText
      ..position = Vector2(_bar.size.x / 5, size.y - _hurryText.size.y));
    _bar.add(ScaleEffect.to(
        targetScale,
        EffectController(
          duration: 0.5,
          reverseDuration: 0.5,
          infinite: true,
        )));
    _border.add(ScaleEffect.to(
        targetScale,
        EffectController(
          duration: 0.5,
          reverseDuration: 0.5,
          infinite: true,
        )));
    _hurryText.add(ScaleEffect.to(
        targetScale,
        EffectController(
          duration: 0.5,
          reverseDuration: 0.5,
          infinite: true,
        )));
  }

  void stopHurryingUp() {
    if (contains(_hurryText)) {
      remove(_hurryText);
    }
    _bar.removeWhere((component) => component is ScaleEffect);
    _border.removeWhere((component) => component is ScaleEffect);
    _bar.scale = Vector2.all(1);
    _border.scale = Vector2.all(1);
  }
}
