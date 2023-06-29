import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

class EffectsComponent extends PositionComponent
    with
        FlameBlocReader<LevelBloc, LevelState>,
        FlameBlocListenable<LevelBloc, LevelState> {
  final Map<int, MapEntry<Items, double>> _effects = {};
  final Map<int, MapEntry<Items, EffectIndicator>> _indicators = {};

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.effects != newState.effects;
  }

  @override
  void onNewState(LevelState state) {
    for (final entry in state.effects.entries) {
      if (_effects.values.map((e) => e.key).contains(entry.value.key)) {
        _effects.removeWhere((key, value) {
          if (value.key == entry.value.key) {
            _removeIndicator(key);
          }
          return value.key == entry.value.key;
        });
      }
      if (!_effects.containsKey(entry.key)) {
        _effects[entry.key] = entry.value;
      }
    }
    _updateIndicators();
  }

  @override
  Future<void> onLoad() async {
    add(TimerComponent(period: 1, repeat: true, onTick: _onTick));
    return super.onLoad();
  }

  void _onTick() {
    final List<int> toRemove = [];
    for (final entry in _effects.entries) {
      print(
          'before: ${_indicators[entry.key]?.key} – ${_indicators[entry.key]?.value.value}');
      var duration = entry.value.value;
      duration--;
      if (entry.value.value == 0) {
        bloc.add(LevelEvent.removeEffect(item: entry.value.key));
        toRemove.add(entry.key);
      } else {
        _effects[entry.key] = MapEntry(entry.value.key, duration);
      }
      _updateIndicators();
      print(
          'after: ${_effects[entry.key]?.key} – ${_effects[entry.key]?.value}');
    }
    for (final e in toRemove) {
      _effects.remove(e);
      _removeIndicator(e);
    }
  }

  void _updateIndicators() {
    void addIndicator(MapEntry<int, MapEntry<Items, double>> entry) {
      final indicator = EffectIndicator(
        item: entry.value.key,
        duration: entry.value.value,
      );
      _indicators[entry.key] = MapEntry(entry.value.key, indicator);
      if (_indicators.length > 1) {
        add(indicator
          ..position = Vector2(
            0,
            _indicators.entries.last.value.value.position.y +
                _indicators.entries.last.value.value.size.y +
                4,
          ));
      } else {
        add(indicator);
      }
    }

    for (final entry in _effects.entries) {
      if (_indicators.containsKey(entry.key)) {
        // print(
        //     'before: ${_indicators[entry.key]?.key} – ${_indicators[entry.key]?.value.value}');
        _indicators[entry.key]?.value.value = entry.value.value;
        // print(
        //     'after: ${_indicators[entry.key]?.key} – ${_indicators[entry.key]?.value.value}');
      } else {
        addIndicator(entry);
      }
    }
  }

  void _removeIndicator(int key) {
    final indicator = _indicators.remove(key)?.value;
    indicator?.removeFromParent();
    final components = children.whereType<PositionComponent>();
    if (components.length > 1) {
      for (var e in components) {
        e.position.y -= e.size.y;
      }
    }
  }
}

class EffectIndicator extends PositionComponent {
  static final _barSize = Vector2(50, 10);

  EffectIndicator({required this.item, required this.duration})
      : super(size: Vector2(78, 20)) {
    _value = duration;
  }

  final Items item;
  final double duration;

  late RectangleComponent _barComponent;
  late double _value;
  double get value => _value;

  set value(double restDuration) {
    if (isMounted) _barComponent.size.x = _barSize.x / duration * restDuration;
  }

  Color get _barColor {
    switch (item) {
      case Items.cocktail:
        return NGTheme.purple1;
      case Items.hourglass:
        return NGTheme.orange1;
      default:
        return const Color(0xff000000);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    final iconComponent = SpriteComponent(
      sprite: await item.sprite,
    )
      ..size = Vector2(20, 20)
      ..position = Vector2(0, 0);
    _barComponent = RectangleComponent(
      size: _barSize,
      position: Vector2(iconComponent.size.x + 8, 5),
      paint: Paint()..color = _barColor,
    );

    add(iconComponent);
    add(_barComponent);
  }
}

extension on Items {
  Future<Sprite> get sprite {
    switch (this) {
      case Items.cocktail:
        return Sprite.load('cocktail.png');
      case Items.hourglass:
        return Sprite.load('hourglass.png');
      default:
        throw UnexpectedError();
    }
  }
}
