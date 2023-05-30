import 'dart:ui';

import 'package:flame/components.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';

extension on Aura {
  Color get color {
    switch (this) {
      case Aura.blue:
        return NGTheme.auraBlue;
      case Aura.green:
        return NGTheme.auraGreen;
      case Aura.red:
        return NGTheme.auraRed;
    }
  }
}

mixin HasAura on PositionComponent {
  Aura get aura;
  Paint get auraPaint => Paint()
    ..color = aura.color
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

  Component get auraComponent;
}
