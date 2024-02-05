import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/game/components/audio_fade_component.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/figure_event_component.dart';
import 'package:normaldo_gaming/game/components/item_components/explosion_component.dart';
import 'package:normaldo_gaming/game/components/item_components/road_sign.dart';
import 'package:normaldo_gaming/game/components/item_components/trash_bin.dart';
import 'package:normaldo_gaming/game/components/level_timer_component.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

import 'normaldo.dart';

class Grid extends PositionComponent
    with
        DragCallbacks,
        HasGameRef,
        FlameBlocReader<LevelBloc, LevelState>,
        FlameBlocListenable<LevelBloc, LevelState>,
        HasNgAudio {
  Grid({
    required this.gameSessionCubit,
    required this.levelBloc,
    required this.skin,
  });

  final Skin skin;
  final GameSessionCubit gameSessionCubit;
  final LevelBloc levelBloc;

  late final Normaldo normaldo;

  double _lineSize = 0;
  double get lineSize => _lineSize;

  Map<int, double> _stoppedLines = {};
  List<double> _linesCentersY = [];
  List<double> get linesCentersY => _linesCentersY;

  bool _controlInverted = false;
  bool controlTurnedOff = false;

  List<double> lineXAllocation(double xSize) {
    const padding = 1.2;
    final width = xSize * padding;
    return List.generate(size.x ~/ width,
        (index) => (((size.x) / 8 * (index + 1))) + (width / 2));
  }

  TimerComponent? _itemsCreator;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level ||
        previousState.miniGame != newState.miniGame;
  }

  bool gameInProgress = false;

  @override
  void onNewState(LevelState state) async {
    if (state.miniGame != null) {
      if (gameInProgress) return;
      gameInProgress = true;
      state.miniGame?.when(
        shredder: () async {
          final audioId = await audio.playAudio('hard_track.mp3', volume: 0.01);
          add(AudioFadeComponent(onTick: () async {
            if (audio.bgmVolume - 0.02 > 0) {
              await audio.setVolumeToBgm(volume: audio.bgmVolume - 0.02);
            } else {
              await audio.setVolumeToBgm(volume: 0);
            }
            await audio.setVolumeToAudio(
                audioId: audioId,
                volume: audio.audioVolume(audioId: audioId) + 0.01);
            if (audio.audioVolume(audioId: audioId) >= 0.1) {
              removeWhere((component) => component is AudioFadeComponent);
            }
          }));
          if (normaldo.skin.assets.sfx['shredder'] != null) {
            audio.playSfx(
              Sfx.binCrash,
              customAssets: normaldo.skin.assets.sfx['shredder']!,
            );
          }
          normaldo.notify(
            text: 'Hmm.. I feel something..'.tr(),
            color: NGTheme.green1,
          );
          _itemsCreator?.timer.pause();
          add(TimerComponent(
              period: 3,
              removeOnFinish: true,
              onTick: () {
                removeAllItems();
                add(ExplosionComponent()..size = size);
                // add(Shredder(audioId: audioId)
                //   ..size = Items.shredder.getSize(lineSize)
                //   ..position = Vector2(0, -100));
              }));
        },
      );
    } else {
      if (gameInProgress) gameInProgress = false;
      gameSessionCubit.changeLevel(state.level.index);
      if (_itemsCreator != null) remove(_itemsCreator!);
      _itemsCreator = TimerComponent(
        period: state.level.frequency,
        repeat: true,
        onTick: () {
          // return;
          if (state.figure != null) return;
          final items = state.level.next().map((e) {
            final component = e.item.component();
            component.size = e.item.getSize(lineSize);
            component.position = Vector2(
                gameRef.size.x + component.size.x * 2,
                _linesCentersY[
                    e.line ?? Random().nextInt(_linesCentersY.length)]);
            return component;
          }).toList();
          items.removeWhere(
              (item) => _stoppedLines.values.contains(item.position.y));
          addAll(items);
        },
      );
      if (state.figure != null) _itemsCreator?.timer.pause();
      add(_itemsCreator!);
    }
  }

  void stopAllLines() {
    for (int i = 0; i < _linesCentersY.length; i++) {
      stopLine(i);
    }
  }

  void stopLine(int index) {
    assert(index >= 0 && index < 5, 'Your index – $index');
    if (_stoppedLines.keys.contains(index)) return;
    _stoppedLines[index] = _linesCentersY[index];
  }

  void resumeLines() {
    final toRemove = <int>[];
    for (final entry in _stoppedLines.entries) {
      toRemove.add(entry.key);
    }
    for (final key in toRemove) {
      _stoppedLines.remove(key);
    }
  }

  void removeAllItems({List<Component> exclude = const []}) {
    removeWhere(
      (component) {
        if (component is FigureEventComponent &&
            exclude.any((element) => component.contains(element))) {
          for (final exclusion in exclude) {
            for (final child in component.children) {
              if (child != exclusion) child.removeFromParent();
            }
          }
          return false;
        }
        return ((component is FigureEventComponent || component is Item) &&
            !exclude.contains(component));
      },
    );
  }

  @override
  Future<void> onLoad() async {
    size = Vector2(gameRef.size.x, gameRef.size.y);
    _lineSize = size.y / Utils.linesCount;
    normaldo = Normaldo(size: Vector2.all(lineSize), skin: skin)
      ..position = Vector2(size.x / 2, size.y / 2);
    for (int i = 0; i < Utils.linesCount; i++) {
      final lineCenterY = lineSize * i + lineSize / 2;
      _linesCentersY.add(lineCenterY);

      // 4DEV
      // line bounds highlights
      // add(RectangleComponent(
      //   position: Vector2(0, (i + 1) * lineSize),
      //   size: Vector2(size.x, 1),
      //   paint: Paint()..color = BasicPalette.yellow.color,
      // ));
      // // centers highlights
      // add(RectangleComponent(
      //   position: Vector2(0, lineCenterY),
      //   size: Vector2(size.x, 0.5),
      //   paint: Paint()..color = BasicPalette.green.color,
      // ));
    }
    // add(
    //   TrashBin()
    //     ..position = Vector2(size.x / 2, _linesCentersY[2])
    //     ..size = Items.trashBin.getSize(lineSize)
    //     ..moving = false,
    // );
    _itemsCreator = TimerComponent(
        period: levelBloc.state.level.frequency,
        repeat: true,
        onTick: () {
          // return;
          if (levelBloc.state.figure != null) return;
          final items = levelBloc.state.level.next().map((e) {
            final component = e.item.component();
            component.size = e.item.getSize(lineSize);
            component.position = Vector2(
                gameRef.size.x + component.size.x * 2,
                _linesCentersY[
                    e.line ?? Random().nextInt(_linesCentersY.length)]);
            return component;
          }).toList();
          items.removeWhere(
              (item) => _stoppedLines.values.contains(item.position.y));
          addAll(items);
        });
    add(_itemsCreator!);
    await add(FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          normaldo,
        ]));
    await add(FlameBlocListener<LevelBloc, LevelState>(
      listenWhen: (previousState, newState) =>
          previousState.figure != newState.figure,
      onNewState: (state) async {
        if (state.figure != null) {
          _itemsCreator?.timer.pause();
          add(TimerComponent(
              period: state.level.frequency,
              removeOnFinish: true,
              onTick: () {
                add(
                  FigureEventComponent(
                    figure: state.figure!,
                    lineSize: lineSize,
                    linesCentersY: linesCentersY,
                    onFinish: () {
                      bloc.add(const LevelEvent.finishFigure());
                    },
                  )
                    ..position = Vector2(0, 0)
                    ..size = size,
                );
              }));
        } else {
          onNewState(state);
        }
      },
    ));
    await add(FlameBlocProvider<LevelBloc, LevelState>.value(
        value: levelBloc,
        children: [
          LevelTimerComponent(),
        ]));
    return super.onLoad();
  }

  void invertControl() {
    _controlInverted = !_controlInverted;
  }

  @override
  void update(double dt) {
    final rightSideX = normaldo.position.x + normaldo.size.x / 2;
    final bottomSideY = normaldo.position.y + normaldo.size.y / 2;
    final leftSideX = normaldo.position.x - normaldo.size.x / 2;
    final topSideY = normaldo.position.y - normaldo.size.x / 2;

    if (rightSideX > size.x) {
      normaldo.position.x = size.x - normaldo.size.x / 2;
    }
    if (bottomSideY > size.y) {
      normaldo.position.y = size.y - normaldo.size.y / 2;
    }
    if (leftSideX < 0) {
      normaldo.position.x = normaldo.size.x / 2;
    }
    if (topSideY < 0) {
      normaldo.position.y = normaldo.size.y / 2;
    }
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    if (!controlTurnedOff) {
      if (_controlInverted) {
        normaldo.position -= event.localDelta * normaldo.speed;
      } else {
        normaldo.position += event.localDelta * normaldo.speed;
      }
    }
    super.onDragUpdate(event);
    return false;
  }
}
