import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';

class Scene extends PositionComponent with HasGameRef {
  Scene({required this.initialSize});

  final Vector2 initialSize;
  final _currentBackgrounds = <SpriteComponent>[];

  @override
  Future<void> onLoad() async {
    _currentBackgrounds.addAll([
      SpriteComponent(
        sprite: await Sprite.load('backgrounds/bg0.png'),
      )
        ..position = position
        ..size = size,
      SpriteComponent(
        sprite: await Sprite.load('backgrounds/bg1.png'),
      )
        ..position = Vector2(size.x, y)
        ..size = size,
    ]);
    addAll(_currentBackgrounds);
    await add(FlameBlocListener<LevelBloc, LevelState>(
      listenWhen: (previousState, newState) =>
          previousState.level.index != newState.level.index,
      onNewState: (state) async {
        _currentBackgrounds.add(SpriteComponent(
          sprite: await Sprite.load(
              'backgrounds/bg${(state.level.index + 1) % 22}.png'),
        )
          ..position = Vector2(initialSize.x, y)
          ..size = size);
        add(_currentBackgrounds.last);
        _move();
      },
    ));

    _move();
    super.onLoad();
  }

  void _move() {
    for (final bg in _currentBackgrounds) {
      bg.add(MoveByEffect(
          Vector2(-initialSize.x, 0),
          EffectController(
              duration: LevelBloc.levelChangeDuration.toDouble(),
              onMax: () {
                if (bg.position.x <= -initialSize.x) {
                  _currentBackgrounds.remove(bg);
                  bg.removeFromParent();
                }
              })));
    }
  }
}
