import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/game/components/effects/effects.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/ninja_foot/ninja_foot.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Scene extends PositionComponent with HasGameRef<PullUpGame>, Effects {
  Scene({required this.initialSize});

  final Vector2 initialSize;
  final _currentBackgrounds = <SpriteAnimationComponent>[];
  var _currentLocationIndex = 0;
  var _currentLevel = -1;
  int get currentLocationIndex => _currentLocationIndex;

  @override
  Future<void> onLoad() async {
    // final spriteSheet = SpriteSheet(
    //     image: await Images().load('/backgrounds/bg0-sheet.png'),
    //     srcSize: Vector2(2400, 1080));
    // final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.07);
    // final aseAnimation = SpriteAnimation.fromAsepriteData(
    //   await Images().load('backgrounds/bg0-sheet.png'),
    //   await AssetsCache().readJson('images/backgrounds/bg0.json'),
    // );
    final level1X = size.y * 26.225;
    final level2X = size.y * 46.54;
    final level1 = await Sprite.load('backgrounds/level1.png');
    final level2 = await Sprite.load('backgrounds/level2.png');
    _currentBackgrounds.addAll([
      SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList([level1], stepTime: 10),
        size: Vector2(level1X, size.y),
      ),
      SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList([level2], stepTime: 10),
        position: Vector2(level1X, 0),
        size: Vector2(level2X, size.y),
      ),
    ]);
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
              speed: 300,
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
                      final ninjaFoot = NinjaFoot();
                      grid.add(ninjaFoot
                        ..position =
                            Vector2(grid.size.x + 100, grid.size.y / 2));
                      ninjaFoot.start();
                    }));
              })));
    }
  }
}
