import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/game/components/effects/effects.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/club_boss/club_boss.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/ninja_foot/ninja_foot.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Scene extends PositionComponent with HasGameRef<PullUpGame>, Effects {
  static const double levelSpeed = 100;

  Scene(
    this._levels, {
    required this.initialSize,
  });

  final Vector2 initialSize;
  final _currentBackgrounds = <SpriteAnimationComponent>[];
  var _currentLocationIndex = 0;
  var _currentLevel = -1;
  int get currentLocationIndex => _currentLocationIndex;
  Level get currentLevel => _levels[_currentLevel];

  final List<Level> _levels;

  Boss get _boss => switch (_currentLevel) {
        0 => NinjaFoot(),
        1 => ClubBoss(),
        _ => NinjaFoot(),
      };

  @override
  Future<void> onLoad() async {
    final level1X = size.y * 21.787;
    final level2X = size.y * 46.54;
    double xOffset = 0;
    for (final level in _levels) {
      final index = _levels.indexOf(level);
      final width = switch (index) {
        0 => level1X,
        _ => level2X,
      };
      final lSize = Vector2(
        width,
        size.y,
        // size.y * (level.bgSprite.image.width / level.bgSprite.image.height),
        // size.y,
      );
      _currentBackgrounds.add(
        SpriteAnimationComponent(
            animation: SpriteAnimation.spriteList(
              [level.bgSprite],
              stepTime: 10,
            ),
            size: lSize,
            position: Vector2(xOffset, 0)),
      );
      xOffset += lSize.x;
    }
    addAll(_currentBackgrounds);
    if (gameRef.userCubit.state.educated) {
      _move();
    }
    add(TimerComponent(
        period: 3,
        repeat: true,
        onTick: () {
          final locationIndex =
              (_currentBackgrounds.first.position.x / size.x).abs().toInt();
          if (_currentLocationIndex != locationIndex) {
            _currentLocationIndex = locationIndex;
            gameRef.missionCubit.applyProgress(MissionType.reachLocation);
          }
        }));
    return super.onLoad();
  }

  void moveToNextLevel() => _move();

  void _move() {
    if (_currentBackgrounds.length - 1 == _currentLevel) return;
    _currentLevel++;
    for (final bg in _currentBackgrounds) {
      bg.add(MoveByEffect(
          Vector2(
              -_currentBackgrounds[_currentLevel].size.x + initialSize.x, 0),
          EffectController(
              speed: levelSpeed,
              onMax: () {
                if (_currentBackgrounds.indexOf(bg) != _currentLevel) return;
                // Preparing to boss
                gameRef.bossInProgress = true;
                const vanishDuration = 0.3;
                final normaldo = game.grid.normaldo;
                game.levelBloc.add(const LevelEvent.finishFigure());
                game.grid.stopAllLines();
                game.grid.removeAllItems();
                game.grid.controlTurnedOff = true;
                normaldo.nComponent.add(fadeOutEffect(
                    duration: vanishDuration,
                    onComplete: () {
                      normaldo.position =
                          Vector2(normaldo.size.x * 2, game.size.y / 2);
                      normaldo.nComponent
                          .add(fadeInEffect(duration: vanishDuration));
                    }));
                add(TimerComponent(
                    period: 1,
                    removeOnFinish: true,
                    onTick: () async {
                      // Creating a boss component
                      final grid = game.grid;
                      final boss = _boss;
                      grid.add(boss
                        ..size = Vector2.all(grid.lineSize)
                        ..position =
                            Vector2(grid.size.x + 100, grid.size.y / 2));
                      boss.start();
                    }));
              })));
    }
  }
}
