import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/application/education/cubit/education_cubit.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/application/mission/mission_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/audio_pools.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/game/components/education/education_component.dart';
import 'package:normaldo_gaming/game/components/fat_counter.dart';
import 'package:normaldo_gaming/game/components/pause_button.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';
import 'package:normaldo_gaming/injection/injection.dart';

import 'components/components.dart';
import 'components/grid.dart';

class PullUpGame extends FlameGame
    with TapCallbacks, DragCallbacks, HasCollisionDetection, HasNgAudio {
  static final menuIconSize = Vector2.all(30);

  final UserCubit userCubit;
  final GameSessionCubit gameSessionCubit;
  final LevelBloc levelBloc;
  final MissionCubit missionCubit;
  final EducationCubit educationCubit;

  PullUpGame({
    required this.userCubit,
    required this.gameSessionCubit,
    required this.levelBloc,
    required this.missionCubit,
    required this.educationCubit,
  });

  // Components
  late final Scene scene;
  final scoreLabel = ScoreLabel();
  final balance = Balance();
  final pauseButton = PauseButton();
  late final FatCounter fatCounter;
  late final Grid grid;

  final sfxPools = AudioPools();

  final _levelManager = injector.get<LevelManager>();
  LevelManager get levelManager => _levelManager;

  bool bossInProgress = false;

  @override
  bool get debugMode => false;

  @override
  void onRemove() {
    missionCubit.resetOneGames();
    if (!gameSessionCubit.state.isDead) {
      missionCubit.resetAllProgress();
    }
    super.onRemove();
  }

  @override
  Future<void> onLoad() async {
    camera.moveTo(size / 2);
    add(TimerComponent(
      period: 1,
      removeOnFinish: true,
      onTick: () {},
    ));
    fatCounter = FatCounter(skin: userCubit.state.skin);
    _initializeComponents();

    await _initBloc();

    // camera.viewfinder.zoom = 0.4;

    if (!userCubit.state.educated) {
      add(TimerComponent(
        period: 0.5,
        removeOnFinish: true,
        onTick: () {
          pauseButton.position -= Vector2(0, 200);
          add(EducationComponent());
        },
      ));
    }

    sfxPools
        .init(userCubit.state.skin)
        .whenComplete(() => print('AUDIO POOLS SUCCESSFULLY LOADED'));

    overlays.add(Overlays.missions.name);

    return super.onLoad();
  }

  void _initializeComponents() {
    scene = Scene(
      initialSize: Vector2(size.x, size.x),
    );
    scene.size = size;
    balance.position =
        Vector2(scoreLabel.x, scoreLabel.y + scoreLabel.size.y + 8);
    fatCounter.position.x = scoreLabel.x + 8;
    fatCounter.position.y = balance.position.y + balance.size.y + 16;
    fatCounter.size = Vector2(90, menuIconSize.y);
  }

  Future<void> _initBloc() async {
    gameSessionCubit.stream.listen((state) async {
      if (state.isDead) {
        await audio.pauseBgm();
        await audio.pauseAllAudios();
        pauseEngine();
        overlays.add(Overlays.deathScreen.name);
      } else {
        if (!state.paused && (state.revived || state.revivedWithAd)) {
          overlays.remove(Overlays.deathScreen.name);
          await audio.resumeBgm();
          await audio.resumeAllAudios();
          resumeEngine();
        }
      }
    });

    await camera.viewfinder.add(FlameBlocProvider<LevelBloc, LevelState>.value(
        value: levelBloc,
        children: [
          scene,
          grid = Grid(
            skin: userCubit.state.skin,
            gameSessionCubit: gameSessionCubit,
            levelBloc: levelBloc,
          )
            ..size = Vector2(size.x, size.y)
            ..position = Vector2(0, 0),
        ]));
    await camera.viewfinder.add(
      FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          RectangleComponent(
              size: Vector2(150, 100),
              paint: Paint()
                ..color = BasicPalette.black.color.withOpacity(0.5)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100)),
          scoreLabel,
          fatCounter,
          balance,
          pauseButton..position = Vector2(size.x - pauseButton.size.x - 32, 0),
        ],
      ),
    );
  }
}
