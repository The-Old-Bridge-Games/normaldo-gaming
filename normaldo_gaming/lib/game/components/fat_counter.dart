import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/core/components/rounded_rectangle_component.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/normaldo_sprites_fixture.dart';

class FatCounter extends PositionComponent with HasGameRef {
  late final RoundedRectangleComponent _bar;
  late final Map<NormaldoFatState, Sprite> _normaldoSprites;

  late SpriteComponent leftSprite;
  late SpriteComponent rightSprite;

  var _normaldoFatState = NormaldoFatState.slim;

  var _fatPoints = 0;
  set fatPoints(int newValue) {
    _fatPoints = newValue;
    _bar.size.x = newValue * 100 / Normaldo.pizzaToGetFatter;
  }

  set normaldoFatState(NormaldoFatState newState) {
    _normaldoFatState = newState;
    final borderStates = newState.prevAndNextStates;
    leftSprite.sprite = _normaldoSprites[borderStates.first];
    rightSprite.sprite = _normaldoSprites[borderStates.last];
  }

  @override
  FutureOr<void> onLoad() async {
    _normaldoSprites = await normaldoSprites();
    _bar = RoundedRectangleComponent(
      radius: const Radius.circular(3),
      paint: Paint()..color = NGTheme.green1,
    );
    final border = RoundedRectangleComponent(
      radius: const Radius.circular(3),
      paint: Paint()
        ..style = PaintingStyle.stroke
        ..color = NGTheme.green1
        ..strokeWidth = 1.4,
    );

    final size = Vector2(100, 20);

    leftSprite = SpriteComponent(
      anchor: Anchor.center,
      sprite: _normaldoSprites[NormaldoFatState.skinny],
      size: Vector2(30, 30),
      position: Vector2(12, y + 10),
    );

    rightSprite = SpriteComponent(
      anchor: Anchor.center,
      sprite: _normaldoSprites[NormaldoFatState.fat],
      size: Vector2(30, 30),
      position: Vector2(160, y + 10),
    );

    add(leftSprite);
    add(rightSprite);
    add(
      border
        ..size = size
        ..position = Vector2(38, y),
    );
    add(
      _bar
        ..size = Vector2(0, size.y)
        ..position = Vector2(38, y),
    );
  }

  @override
  void update(double dt) {
    final fPoints = (gameRef as PullUpGame).grid.normaldo.fatPoints;
    final fatState = (gameRef as PullUpGame).grid.normaldo.current;
    if (fPoints != _fatPoints) {
      fatPoints = fPoints;
    }
    if (fatState != _normaldoFatState && fatState != null) {
      normaldoFatState = fatState;
    }
  }
}

extension on NormaldoFatState {
  // ignore: unused_element
  List<NormaldoFatState> get prevAndNextStates {
    switch (this) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.skinnyDead:
      case NormaldoFatState.skinnyEat:
        return [NormaldoFatState.skinny, NormaldoFatState.slim];
      case NormaldoFatState.slim:
      case NormaldoFatState.slimDead:
      case NormaldoFatState.slimEat:
        return [NormaldoFatState.skinny, NormaldoFatState.fat];
      case NormaldoFatState.fat:
      case NormaldoFatState.fatDead:
      case NormaldoFatState.fatEat:
        return [NormaldoFatState.slim, NormaldoFatState.uberFat];
      case NormaldoFatState.uberFat:
      case NormaldoFatState.uberFatDead:
      case NormaldoFatState.uberFatEat:
        return [NormaldoFatState.fat, NormaldoFatState.uberFat];
    }
  }
}
