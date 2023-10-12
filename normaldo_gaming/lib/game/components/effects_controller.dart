import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';

import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class EffectsController extends PositionComponent
    with FlameBlocReader<LevelBloc, LevelState>, HasGameRef {
  /// item => current duration
  final void Function(Items item, double duration) onNewState;

  EffectsController({required this.onNewState});

  final Map<Items, double> _current = {};
  final Map<Items, TimerComponent> _timers = {};

  List<Items> get effectsInProgress => _timers.keys.toList();

  void addEffect(Items item, double duration) {
    if (effectsInProgress.contains(item)) {
      final newDuration = _current[item]! + duration;
      onNewState(item, newDuration);
      _current[item] = newDuration;
      _timers[item]?.timer.stop();
      _addNewTimer(item);
    } else {
      onNewState(item, duration);
      _current[item] = duration;
      _addNewTimer(item);
      _handleEffect(item);
    }
  }

  void _handleEffect(Items item) {
    switch (item) {
      case Items.hourglass:
        bloc.add(LevelEvent.changeSpeed(
          speed: bloc.state.level.speed / 2,
          effects: (gameRef as PullUpGame)
              .grid
              .normaldo
              .effectsController
              .effectsInProgress,
        ));
      default:
        break;
    }
  }

  void _stopEffect(Items item) {
    switch (item) {
      case Items.hourglass:
        bloc.add(LevelEvent.changeSpeed(
          speed: bloc.state.level.speed * 2,
          effects: (gameRef as PullUpGame)
              .grid
              .normaldo
              .effectsController
              .effectsInProgress,
        ));
      default:
        break;
    }
  }

  void _addNewTimer(Items item) {
    final timer = TimerComponent(
      period: 1,
      repeat: true,
      onTick: () {
        final current = _current[item] ?? 0;
        if (current == 0) {
          _timers[item]?.timer.stop();
          _timers.remove(item);
          _current.remove(item);
          _stopEffect(item);
        } else {
          final newDuration = _current[item]! - 1;
          _current[item] = newDuration;
          onNewState(item, newDuration);
        }
      },
    );
    _timers[item] = timer;
    add(timer);
  }
}
