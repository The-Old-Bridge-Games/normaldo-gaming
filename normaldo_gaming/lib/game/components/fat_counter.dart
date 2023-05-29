import 'dart:async';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

import 'normaldo.dart';

class FatCounter extends PositionComponent with HasGameRef {
  final _counterText =
      TextComponent(textRenderer: TextPaint(style: NGTheme.bodySmall));

  var _fatPoints = 0;
  set fatPoints(int newValue) {
    _counterText.text = '$newValue/${Normaldo.pizzaToGetFatter}';
    _fatPoints = newValue;
  }

  @override
  FutureOr<void> onLoad() {
    add(_counterText..text = '0/${Normaldo.pizzaToGetFatter}');
  }

  @override
  void update(double dt) {
    final fPoints = (gameRef as PullUpGame).grid.normaldo.fatPoints;
    if (fPoints != _fatPoints) {
      fatPoints = fPoints;
    }
  }
}
