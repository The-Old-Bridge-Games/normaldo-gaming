import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/pull_up_game/widgets/mission_tile.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class DeathScreen extends StatefulWidget {
  const DeathScreen({super.key});

  @override
  State<DeathScreen> createState() => _DeathScreenState();
}

class _DeathScreenState extends State<DeathScreen> with HasNgAudio {
  static const _iconDimension = 30.0;

  late final int _audioId;

  final _levelManager = injector.get<LevelManager>();

  double _opacity = 0.0;

  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    audio.loopAudio('death_audio.mp3').then((id) => _audioId = id);

    final gameCubit = context.read<GameSessionCubit>();
    final userCubit = context.read<UserCubit>();

    if (gameCubit.state.score > userCubit.state.user.highScore) {
      userCubit.changeHighScore(gameCubit.state.score);
    }
    userCubit.addDollars(gameCubit.state.dollars);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _opacity = 1.0;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final textTheme = Theme.of(context).textTheme;
      await Future.delayed(const Duration(seconds: 2));
      final missions = List.from(_levelManager.missions);
      final removeIndexes = missions
          .where((m) => m.completed)
          .map((e) => missions.indexOf(e))
          .toList();
      for (final index in removeIndexes) {
        _animatedListKey.currentState?.removeItem(
          index,
          duration: const Duration(seconds: 2),
          (context, animation) {
            return FadeTransition(
              opacity: animation.drive(TweenSequence([
                TweenSequenceItem(
                    tween: Tween(begin: 1.0, end: 1.0), weight: 0.7),
                TweenSequenceItem(
                    tween: Tween(begin: 1.0, end: 0.0), weight: 0.3),
              ])),
              child: Container(
                height: MissionTile.height,
                decoration: BoxDecoration(
                  color: NGTheme.orange1,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '+ ${missions[index].exp} EXP',
                        style: textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        userCubit.addExp(missions[index].exp);
        _levelManager.remove(missions[index]);
        await Future.delayed(const Duration(seconds: 2));
        _levelManager.insertNewMission(index);
        _animatedListKey.currentState
            ?.insertItem(index, duration: const Duration(milliseconds: 300));
        await Future.delayed(const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    audio.stopAudio(_audioId);
    _levelManager.cleanProgress();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSessionCubit>();
    return Scaffold(
      backgroundColor: NGTheme.bgSemiBlack,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 65, vertical: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NGTheme.purple3, width: 3),
            ),
            child: Row(
              children: [
                Expanded(child: _buildMissions()),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserLevelBar(
                          levelManager: _levelManager,
                          barWidth: 223,
                        ),
                        const SizedBox(height: 32.0),
                        _buildScore(context, cubit.state.score),
                        const SizedBox(height: 32.0),
                        _buildDollars(context, cubit.state.dollars),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BouncingButton(
                              onPressed: () => context.pop(),
                              child: Image.asset(
                                'assets/images/menu_bubble_button.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 32),
                            BouncingButton(
                              onPressed: () async {
                                await audio.stopBgm();
                                // ignore: use_build_context_synchronously
                                context
                                    .pushReplacement(NGRoutes.pullUpGame.path);
                              },
                              child: Image.asset(
                                'assets/images/retry_bubble_button.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewRecordText() {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return Visibility(
        visible:
            state.user.highScore < context.read<GameSessionCubit>().state.score,
        child: BlinkingText(
          'NEW HIGH SCORE!!!',
          style: textTheme.displaySmall?.copyWith(color: NGTheme.green1),
          duration: const Duration(milliseconds: 500),
          endDelay: const Duration(seconds: 1),
        ),
      );
    });
  }

  Widget _buildMissions() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text('missions', style: textTheme.displayLarge),
        const SizedBox(height: 18),
        AnimatedList(
          key: _animatedListKey,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          initialItemCount: _levelManager.missions.length,
          itemBuilder: (context, index, animation) {
            final mission = _levelManager.missions[index];
            final progress = mission.type == MissionType.finishGame
                ? null
                : _levelManager.progressOf(mission) ?? 0;
            return FadeTransition(
              key: UniqueKey(),
              opacity: animation.drive(Tween(
                begin: 0,
                end: 1,
              )),
              child: MissionTile(
                  mission: mission,
                  progressText:
                      progress == null ? null : '($progress/${mission.value})'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildScore(BuildContext context, int score) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/pizza.png',
          height: _iconDimension,
          width: _iconDimension,
        ),
        const SizedBox(width: 8),
        Text(
          score.toString(),
          style: textTheme.displayLarge,
        ),
        const Spacer(),
        _buildNewRecordText(),
      ],
    );
  }

  Widget _buildDollars(BuildContext context, int dollars) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/dollar.png',
          height: _iconDimension,
          width: _iconDimension,
        ),
        const SizedBox(width: 8),
        Text(
          dollars.toString(),
          style: textTheme.displayLarge,
        )
      ],
    );
  }
}
