import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Scene extends PositionComponent with HasGameRef<PullUpGame> {
  Scene({required this.initialSize});

  final Vector2 initialSize;
  final _currentBackgrounds = <SpriteAnimationComponent>[];

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
    final sprite = await Sprite.load('backgrounds/level1.png');
    _currentBackgrounds.add(SpriteAnimationComponent(
      animation: SpriteAnimation.spriteList([sprite], stepTime: 10),
      size: Vector2(size.y * 26.225, size.y),
    ));
    addAll(_currentBackgrounds);
    _move();
    return super.onLoad();
    final imagesList = await Images().loadAll(List.generate(
        44, (index) => 'backgrounds/bg0/normaldo${index + 1}.png'));
    final spriteList = imagesList.map((e) => Sprite(e)).toList();
    final frameAnimation =
        SpriteAnimation.spriteList(spriteList, stepTime: 0.07);
    _currentBackgrounds.addAll([
      SpriteAnimationComponent(
        position: position,
        size: size,
        animation: frameAnimation,
      ),
      SpriteAnimationComponent(
        size: size,
        position: Vector2(size.x, y),
        animation: SpriteAnimation.spriteList(
          [Sprite(await Images().load('backgrounds/bg1.png'))],
          stepTime: 0.07,
        ),
      ),
    ]);
    addAll(_currentBackgrounds);
    await add(FlameBlocListener<LevelBloc, LevelState>(
      listenWhen: (previousState, newState) =>
          previousState.level.index != newState.level.index,
      onNewState: (state) async {
        final index = (state.level.index + 1) % 22;
        _currentBackgrounds.add(SpriteAnimationComponent(
          animation: index == 0
              ? frameAnimation
              : SpriteAnimation.spriteList(
                  [Sprite(await Images().load('backgrounds/bg$index.png'))],
                  stepTime: 0.07,
                ),
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
          Vector2(-bg.size.x + initialSize.x, 0),
          EffectController(
              duration: LevelBloc.levelChangeDuration.toDouble(),
              onMax: () {
                // if (bg.position.x <= -initialSize.x) {
                //   _currentBackgrounds.remove(bg);
                //   bg.removeFromParent();
                // }
                game.grid.stopAllLines();
              })));
    }
  }
}
