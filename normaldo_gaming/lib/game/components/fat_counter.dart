import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/normaldo_sprites_fixture.dart';

class FatCounter extends PositionComponent with HasGameRef {
  late final RectangleComponent _bar;
  late final Map<NormaldoFatState, Sprite> _normaldoSprites;

  late SpriteComponent leftSprite;
  late SpriteComponent rightSprite;

  final barSize = Vector2(50, 10);

  var _normaldoFatState = NormaldoFatState.slim;

  var _fatPoints = 0;
  set fatPoints(int newValue) {
    _fatPoints = newValue;
    _bar.size.x = barSize.x / Normaldo.pizzaToGetFatter * newValue;
  }

  set normaldoFatState(NormaldoFatState newState) {
    _normaldoFatState = newState;
    final borderStates = newState.prevAndNextStates;
    leftSprite.sprite = _normaldoSprites[borderStates.first];
    rightSprite.sprite = _normaldoSprites[borderStates.last];
  }

  @override
  FutureOr<void> onLoad() async {
    final iconSize = Vector2.all(20);
    final barPosition = Vector2(iconSize.x, barSize.y / 2);
    _normaldoSprites = await normaldoSprites();
    _bar = RectangleComponent(
      paint: Paint()..color = NGTheme.green1,
    )
      ..size = Vector2(0, barSize.y)
      ..position = barPosition;
    final border = RectangleComponent(
        paint: Paint()..color = NGTheme.green2.withOpacity(0.5));

    leftSprite = SpriteComponent(
      anchor: Anchor.center,
      sprite: _normaldoSprites[NormaldoFatState.skinnyDead],
      size: iconSize,
      position: Vector2(0, size.y / 2),
    );

    rightSprite = SpriteComponent(
      anchor: Anchor.center,
      sprite: _normaldoSprites[NormaldoFatState.fat],
      size: iconSize,
      position: Vector2(size.x - iconSize.x / 2 + 8, size.y / 2),
    );

    add(leftSprite);
    add(rightSprite);
    add(
      border
        ..size = barSize
        ..position = barPosition,
    );
    add(_bar);
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
        return [NormaldoFatState.skinnyDead, NormaldoFatState.slim];
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
