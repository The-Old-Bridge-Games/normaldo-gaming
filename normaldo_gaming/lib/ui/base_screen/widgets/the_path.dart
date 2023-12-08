import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/pull_up_game/entities/reward.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ThePath extends StatefulWidget {
  const ThePath({super.key});

  @override
  State<ThePath> createState() => _ThePathState();
}

class _ThePathState extends State<ThePath> {
  final _levelManager = injector.get<LevelManager>();
  final _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _itemScrollController.scrollTo(
        index: context.read<UserCubit>().state.user.level - 1,
        alignment: 0.5,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemScrollController: _itemScrollController,
        itemCount: _levelManager.levelUpRewards.length,
        itemBuilder: (context, index) {
          final reward = _levelManager.levelUpRewards[index];
          return _buildChild(context, reward, index);
        });
  }

  Widget _buildChild(BuildContext context, List<Reward> reward, int index) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: .5),
      height: 67,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment:
            index == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (reward
              .any((element) => element is TextReward || element is RankReward))
            _buildTextAndRank(reward, index, textTheme)
          else
            const Spacer(flex: 3),
          if (reward.any((element) =>
              element is SkinReward ||
              element is BucksReward ||
              element is ExtraLiveReward))
            _buildSkinBucksLivesReward(reward),
          Stack(
            alignment: index == 0
                ? const Alignment(0, -0.4)
                : index == _levelManager.levelUpRewards.length - 1
                    ? const Alignment(0, 0.4)
                    : const Alignment(0, 0),
            children: [
              if (index == 0 ||
                  index == _levelManager.levelUpRewards.length - 1)
                Transform.translate(
                  offset: const Offset(0.5, 0),
                  child: _buildPathPart(index),
                )
              else
                _buildPathPart(index),
              Text((index + 1).toString(), style: textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkinBucksLivesReward(List<Reward> reward) {
    const dimension = 25.0;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: reward
              .where((e) =>
                  e is BucksReward || e is ExtraLiveReward || e is SkinReward)
              .map((reward) => Expanded(
                    child: switch (reward) {
                      BucksReward() => Image.asset(
                          'assets/images/dollar.png',
                          width: dimension,
                        ),
                      ExtraLiveReward() => Image.asset(
                          'assets/images/heart.png',
                          width: dimension,
                        ),
                      SkinReward() => Image.asset(
                          'assets/images/viking_helmet.png',
                          height: dimension,
                        ),
                      _ => throw UnexpectedError(),
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildTextAndRank(
      List<Reward> reward, int index, TextTheme textTheme) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(
          right: 16,
          bottom: index == 0 ? 12 : 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: reward
              .where(
                  (element) => element is TextReward || element is RankReward)
              .map((reward) => switch (reward) {
                    TextReward() => Text(
                        reward.text.tr(),
                        style: textTheme.displaySmall,
                        textAlign: TextAlign.end,
                      ),
                    RankReward() => Text(
                        reward.rank.tr(),
                        style: textTheme.displaySmall,
                        textAlign: TextAlign.end,
                      ),
                    _ => throw UnexpectedError(),
                  })
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPathPart(int index) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      final user = state.user;
      if (index == 0) {
        return Image.asset('assets/images/ui/the_path/start_path_active.png');
      }
      if (index == _levelManager.levelUpRewards.length - 1) {
        if (user.level == _levelManager.levelUpRewards.length) {
          return Image.asset('assets/images/ui/the_path/end_path_active.png');
        } else {
          return Image.asset('assets/images/ui/the_path/end_path_inactive.png');
        }
      }
      if (index > 0 && index < _levelManager.levelUpRewards.length) {
        if (user.level >= index + 1) {
          return Image.asset(
              'assets/images/ui/the_path/middle_path_active.png');
        } else {
          return Image.asset(
              'assets/images/ui/the_path/middle_path_inactive.png');
        }
      }
      throw UnexpectedError();
    });
  }
}

class PathRewardTile extends StatelessWidget {
  const PathRewardTile({super.key, required this.reward});

  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return const Row();
  }
}
