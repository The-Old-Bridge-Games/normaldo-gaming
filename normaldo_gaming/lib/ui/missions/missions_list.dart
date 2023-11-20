import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/missions/missions_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/ui/pull_up_game/widgets/mission_tile.dart';

class MissionsList extends StatefulWidget {
  const MissionsList({super.key});

  @override
  State<MissionsList> createState() => _MissionsListState();
}

class _MissionsListState extends State<MissionsList> {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  List<Mission> _missions = [];

  Widget _transition({
    required Widget child,
    required Animation<double> animation,
    bool isForward = true,
    Key? key,
  }) {
    return SlideTransition(
      key: key,
      position: TweenSequence<Offset>([
        if (isForward)
          TweenSequenceItem(
              tween: Tween<Offset>(
                begin: const Offset(-2, 0),
                end: const Offset(0, 0),
              ),
              weight: 0.1)
        else
          TweenSequenceItem(
              tween: Tween<Offset>(
                begin: const Offset(0, 0),
                end: const Offset(0, 0),
              ),
              weight: 0.9),
        if (isForward)
          TweenSequenceItem(
              tween: Tween<Offset>(
                begin: const Offset(0, 0),
                end: const Offset(0, 0),
              ),
              weight: 0.9)
        else
          TweenSequenceItem(
              tween: Tween<Offset>(
                begin: const Offset(-2, 0),
                end: const Offset(0, 0),
              ),
              weight: 0.1)
      ]).animate(animation),
      child: child,
    );
  }

  void _cubitListener(BuildContext context, MissionsState state) {
    state.maybeWhen(
      success: (progress) {
        setState(() {
          _missions = progress.keys.toList();
        });
      },
      replaced: (replacement) async {
        const duration = Duration(seconds: 1);
        final copiedMissions = List<Mission>.from(_missions);
        final oldMission = copiedMissions.removeAt(replacement.$1);
        copiedMissions.insert(replacement.$1, replacement.$2);
        setState(() {
          _missions = copiedMissions;
        });
        _animatedListKey.currentState?.removeItem(
          replacement.$1,
          (context, animation) => _transition(
            animation: animation,
            child: _buildCompletedContainer(exp: oldMission.exp),
          ),
          duration: duration,
        );
        Future.delayed(duration * 1).whenComplete(() {
          _animatedListKey.currentState
              ?.insertItem(replacement.$1, duration: duration);
        });
      },
      orElse: () {},
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<MissionsCubit>().loadMissions();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<MissionsCubit, MissionsState>(
        listener: _cubitListener,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Center(
              child: BlinkingText(
                'Loading..'.tr(),
                style: textTheme.displayLarge,
                duration: const Duration(milliseconds: 500),
              ),
            ),
            failed: (failure) => Center(
              child: Text(
                failure.toString(),
                style: textTheme.displaySmall,
              ),
            ),
            orElse: () => AnimatedList(
                key: _animatedListKey,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                initialItemCount: _missions.length,
                itemBuilder: (context, index, animation) {
                  final mission = _missions[index];
                  return _transition(
                    animation: animation,
                    child: MissionTile(
                      mission: mission,
                      onSkippedByAd: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        // ignore: use_build_context_synchronously
                        context
                            .read<MissionsCubit>()
                            .complete(_missions, index);
                        // ignore: use_build_context_synchronously
                        context.read<UserCubit>().addExp(mission.exp);
                      },
                    ),
                  );
                }),
          );
        });
  }

  Widget _buildCompletedContainer({required int exp}) {
    return ExpEarnContainer(exp: exp);
  }
}

class ExpEarnContainer extends StatefulWidget {
  const ExpEarnContainer({
    super.key,
    required this.exp,
  });

  final int exp;

  @override
  State<ExpEarnContainer> createState() => _ExpEarnContainerState();
}

class _ExpEarnContainerState extends State<ExpEarnContainer> {
  var _completed = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _completed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _completed ? 1 : 0,
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
                '+ ${widget.exp} EXP',
                style: textTheme.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
