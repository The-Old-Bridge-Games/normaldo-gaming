import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';
import 'package:normaldo_gaming/ui/widgets/rank_label.dart';

class UserLevelBar extends StatefulWidget {
  const UserLevelBar({
    required this.levelManager,
    required this.barWidth,
    this.rankStyle,
    this.iconSize,
    super.key,
  });

  final LevelManager levelManager;
  final double barWidth;
  final TextStyle? rankStyle;
  final double? iconSize;

  @override
  State<UserLevelBar> createState() => _LevelBarState();
}

class _LevelBarState extends State<UserLevelBar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RankLabel(style: widget.rankStyle),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/pizza_pack1.png',
              fit: BoxFit.cover,
              height: widget.iconSize ?? 30,
              width: widget.iconSize ?? 30,
            ),
            const SizedBox(width: 8),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) => Text(
                '${state.user.level}',
                style: textTheme.displayMedium,
              ),
            ),
            const SizedBox(width: 16),
            BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: widget.barWidth,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        decoration: BoxDecoration(
                          color: NGTheme.orange1,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        height: 25,
                        width: widget.levelManager.isMaxLevel(state.user)
                            ? widget.barWidth
                            : widget.barWidth /
                                widget.levelManager.nextLevelExp(state.user) *
                                state.user.exp,
                      ),
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 2,
                        child: Text(
                          widget.levelManager.isMaxLevel(state.user)
                              ? 'max level'
                              : '${state.user.exp}/${widget.levelManager.nextLevelExp(state.user)}',
                          textAlign: TextAlign.center,
                          style: textTheme.displaySmall,
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: BouncingButton(
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    context.read<UserCubit>().addExp(30);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
