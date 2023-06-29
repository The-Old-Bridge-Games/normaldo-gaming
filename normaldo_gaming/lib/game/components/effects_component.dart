import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

class _EffectData {
  _EffectData({
    required this.item,
    required this.duration,
    double? currentDuration,
  }) : currentDuration = currentDuration ?? duration;

  final Items item;
  final double duration;
  double currentDuration;
}

class EffectsComponent extends PositionComponent
    with
        FlameBlocReader<LevelBloc, LevelState>,
        FlameBlocListenable<LevelBloc, LevelState> {
  final Map<int, _EffectData> _effects = {};

  List<EffectIndicator> get indicators =>
      children.whereType<EffectIndicator>().toList();

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.effects != newState.effects;
  }

  @override
  void onNewState(LevelState state) {
    for (final entry in state.effects.entries) {
      if (!_effects.containsKey(entry.key)) {
        if (_effects.values
            .any((effectData) => effectData.item == entry.value.key)) {
          final oldEntry = _effects.entries.firstWhere(
              (innerEntry) => innerEntry.value.item == entry.value.key);
          _effects[oldEntry.key] = _EffectData(
            item: oldEntry.value.item,
            duration: entry.value.value,
          );
        } else {
          _effects[entry.key] = _EffectData(
            item: entry.value.key,
            duration: entry.value.value,
          );
        }
      }
    }

    final List<int> toRemove = [];
    for (final timestamp in _effects.keys) {
      if (!state.effects.keys.contains(timestamp)) {
        toRemove.add(timestamp);
      }
    }
    for (final removed in toRemove) {
      _effects.remove(removed);
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
      _effects[entry.key]?.currentDuration--;
      if (_effects[entry.key]?.currentDuration == 0) {
        toRemove.add(entry.key);
      }
    }
    for (final removed in toRemove) {
      _removeEffect(removed, _effects[removed]!.item);
    }
    _updateIndicators();
  }

  void _updateIndicators() {
    void addIndicator(_EffectData effectData) {
      final indicator = EffectIndicator(
        item: effectData.item,
        duration: effectData.duration,
      );
      if (indicators.isNotEmpty) {
        add(indicator
          ..position = Vector2(
            0,
            indicators.last.position.y + indicators.last.size.y + 4,
          ));
      } else {
        add(indicator);
      }
      indicators.add(indicator);
    }

    for (final entry in _effects.entries) {
      final data = entry.value;
      if (indicators.every((indicator) => indicator.item != data.item)) {
        addIndicator(entry.value);
      }
      for (final indicator in indicators) {
        if (indicator.item == data.item) {
          indicator.duration = data.duration;
          indicator.value = data.currentDuration;
        }
      }
    }

    final List<EffectIndicator> toRemove = [];
    for (final indicator in indicators) {
      // if effects don't have item as existing indicators do
      if (_effects.entries
          .where((entry) => entry.value.item == indicator.item)
          .isEmpty) {
        toRemove.add(indicator);
      }
    }
    for (final removed in toRemove) {
      _removeIndicator(removed);
    }
  }

  void _removeEffect(int timestamp, Items item) {
    _effects.remove(timestamp);
    bloc.add(LevelEvent.removeEffect(item: item));
  }

  void _removeIndicator(EffectIndicator indicator) {
    final index = indicators.indexOf(indicator);
    indicator.removeFromParent();
    indicators.remove(indicator);
    final components = children.whereType<PositionComponent>().toList();
    for (var e in components) {
      if (components.indexOf(e) >= index) {
        e.position.y -= e.size.y;
      }
    }
  }
}

class EffectIndicator extends PositionComponent {
  static final _barSize = Vector2(50, 10);

  EffectIndicator({required this.item, required this.duration})
      : _value = duration,
        super(size: Vector2(78, 20)) {
    _value = duration;
  }

  final Items item;

  late RectangleComponent _barComponent;
  double duration;
  double _value;
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
