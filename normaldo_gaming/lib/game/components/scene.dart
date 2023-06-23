import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/level_iterator.dart';

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
    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
      listenWhen: (previousState, newState) =>
          previousState.level != newState.level,
      onNewState: (state) async {
        _currentBackgrounds.add(SpriteComponent(
          sprite:
              await Sprite.load('backgrounds/bg${(state.level + 1) % 22}.png'),
        )
          ..position = Vector2(initialSize.x, y)
          ..size = size);
        add(_currentBackgrounds.last);
        _move();
        print(children.length);
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
              duration: LevelIterator.levelChangeSeconds,
              onMax: () {
                if (bg.position.x < 0) {
                  _currentBackgrounds.remove(bg);
                  bg.removeFromParent();
                }
              })));
    }
  }
}
