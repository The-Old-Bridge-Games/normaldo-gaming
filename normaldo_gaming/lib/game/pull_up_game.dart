import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/game/components/fat_counter.dart';
import 'package:normaldo_gaming/game/components/pause_button.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';
import 'package:normaldo_gaming/injection/injection.dart';

import 'components/components.dart';
import 'components/grid.dart';
import 'components/mission_notification_component.dart';

class PullUpGame extends FlameGame
    with TapCallbacks, DragCallbacks, HasCollisionDetection, HasNgAudio {
  static final menuIconSize = Vector2.all(30);

  PullUpGame({
    required this.userCubit,
    required this.gameSessionCubit,
    required this.levelBloc,
  });

  final UserCubit userCubit;
  final GameSessionCubit gameSessionCubit;
  final LevelBloc levelBloc;

  // Components
  late final Scene scene;
  final scoreLabel = ScoreLabel();
  final balance = Balance();
  final pauseButton = PauseButton();
  final fatCounter = FatCounter();
  late final Grid grid;

  final _levelManager = injector.get<LevelManager>();

  double get _notificationXOffset => (size.x / 2) - 150;

  @override
  Future<void> onLoad() async {
    _initializeComponents();

    await _initBloc();

    _levelManager.completedMissions.listen((completedMission) {
      print('COMPLETED: $completedMission');
      _showCompletedMission(completedMission);
    });

    add(TimerComponent(
      period: 0.5,
      removeOnFinish: true,
      onTick: () {
        _showMissions();
      },
    ));
    add(TimerComponent(
      period: 0.1,
      removeOnFinish: true,
      onTick: () {
        if (!userCubit.state.educated) {
          pauseEngine();
          overlays.add(Overlays.onboarding.name);
        }
      },
    ));

    return super.onLoad();
  }

  void _showMissions() {
    audio.playSfx(Sfx.missionCompleted);
    void showMission(Mission mission) {
      final component = MissionNotificationComponent(
        mission: mission,
        completed: false,
      );
      add(component
        ..anchor = Anchor.topCenter
        ..position = Vector2(_notificationXOffset, -100)
        ..add(_missionDismissEffect(onComplete: () {
          remove(component);
        })));
    }

    for (final mission in _levelManager.missions) {
      add(TimerComponent(
        period: 2.6 * _levelManager.missions.indexOf(mission),
        removeOnFinish: true,
        onTick: () => showMission(mission),
      ));
    }
  }

  void _showCompletedMission(Mission mission) {
    audio.playSfx(Sfx.missionCompleted);
    final missionNotificationComponent =
        MissionNotificationComponent(mission: mission);
    add(missionNotificationComponent
      ..anchor = Anchor.topCenter
      ..position = Vector2(_notificationXOffset, -100)
      ..add(
        _missionDismissEffect(onComplete: () {
          remove(missionNotificationComponent);
        }),
      ));
  }

  Effect _missionDismissEffect({required void Function() onComplete}) {
    return MoveEffect.to(
      Vector2(_notificationXOffset, 8.0),
      EffectController(
        duration: .3,
        atMaxDuration: 2,
        reverseDuration: .3,
      ),
      onComplete: onComplete,
    );
  }

  void _initializeComponents() {
    scene = Scene(initialSize: Vector2(size.x, size.x));
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

    await add(FlameBlocProvider<LevelBloc, LevelState>.value(
        value: levelBloc,
        children: [
          scene,
          grid = Grid(
            gameSessionCubit: gameSessionCubit,
            levelBloc: levelBloc,
          )
            ..size = Vector2(size.x, size.y)
            ..position = Vector2(0, 0),
        ]));
    await add(
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
