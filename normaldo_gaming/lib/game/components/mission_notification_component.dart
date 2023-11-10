import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/components/rounded_rectangle_component.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/game/utils/mission_tr_ext.dart';

class MissionNotificationComponent extends PositionComponent {
  MissionNotificationComponent({
    required this.mission,
    this.completed = true,
  });

  final Mission mission;
  final bool completed;

  Future<Sprite> starSprite() async {
    return switch (mission.exp) {
      1 => Sprite.load('pizza_pack1.png'),
      2 => Sprite.load('pizza_pack2.png'),
      3 => Sprite.load('pizza_pack3.png'),
      _ => throw UnexpectedError(),
    };
  }

  @override
  FutureOr<void> onLoad() async {
    SpriteComponent? checkmarkComponent = null;
    if (completed) {
      checkmarkComponent = SpriteComponent(
        anchor: Anchor.center,
        size: Vector2(0, 0),
        position: Vector2(16.0 + 36.0 - 8.0, 8.0 + 36.0 - 8.0),
        sprite: await Sprite.load('checkmark.png'),
      );
    }
    final notificationCard = RoundedRectangleComponent(
        radius: const Radius.circular(8.0),
        size: Vector2(300, 50),
        paint: Paint()
          ..color = NGTheme.purple2
          ..strokeWidth = 5.0);
    add(notificationCard
      ..addAll([
        SpriteComponent(
          sprite: await starSprite(),
          size: Vector2.all(36.0),
          position: Vector2(16.0, 8.0),
        ),
        TextBoxComponent(
            text: mission.trDescription(),
            boxConfig: TextBoxConfig(
              timePerChar: 2 / mission.description.length,
              margins: EdgeInsets.zero,
            ),
            size: Vector2(
              notificationCard.size.x - (16 + 36 + 8) - 16,
              notificationCard.size.y - 16,
            ),
            position: Vector2(16 + 36 + 16.0, 8.0),
            textRenderer: TextPaint(
              style: NGTheme.bodySmall.copyWith(
                fontSize: 10.0,
                overflow: TextOverflow.clip,
              ),
            )),
        RoundedRectangleComponent(
          radius: const Radius.circular(8.0),
          size: Vector2(300, 50),
          paint: Paint()
            ..color = NGTheme.purple3
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5.0,
        ),
      ]));
    if (completed) {
      notificationCard.add(
        checkmarkComponent!
          ..add(
            SizeEffect.to(
              Vector2(30, 20),
              EffectController(startDelay: 1, duration: 0.3),
            ),
          ),
      );
    }
    return super.onLoad();
  }
}
