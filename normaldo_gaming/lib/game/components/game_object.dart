import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/injection/injection.dart';

mixin GameObject {
  double speed = 0.0;

  Aura get aura;
  Paint get auraPaint => Paint()
    ..color = aura.color
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

  Component get auraComponent;

  bool get isSoloSpawn;

  NgAudio get audio => injector.get();
}

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
