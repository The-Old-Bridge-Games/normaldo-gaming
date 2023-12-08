import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/domain/pull_up_game/entities/reward.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class NewLevelDialog extends StatelessWidget {
  const NewLevelDialog({
    required this.reward,
    required this.level,
    super.key,
  });

  final List<Reward> reward;
  final int level;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          BlinkingText(
            'NEW LEVEL!',
            duration: const Duration(milliseconds: 500),
            endDelay: const Duration(seconds: 2),
            style: textTheme.displayLarge?.copyWith(fontSize: 48),
          ),
          const SizedBox(height: 32),
          Container(
            // width: MediaQuery.of(context).size.width / 2,
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NGTheme.green1, width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pizza_pack1.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 16),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text('${level - 1} –> $level',
                          style: textTheme.displayLarge),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildRewards(context),
                const SizedBox(height: 32),
                BouncingButton(
                  onPressed: () => context.pop(),
                  child: Text('OK'.tr(), style: textTheme.displayLarge),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewards(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: reward
          .where((e) =>
              e is RankReward ||
              e is BucksReward ||
              e is ExtraLiveReward ||
              e is SkinReward)
          .map((e) => switch (e) {
                RankReward() => Text(
                    '${'NEW RANK!'.tr()}\n<<< ${e.rank} >>>'.tr(),
                    style: textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                BucksReward() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/dollar.png',
                          width: 30,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          e.amount.toString(),
                          style: textTheme.displayMedium,
                        )
                      ],
                    ),
                  ),
                ExtraLiveReward() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/heart.png',
                          width: 30,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          e.amount.toString(),
                          style: textTheme.displayMedium,
                        )
                      ],
                    ),
                  ),
                SkinReward() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'NEW SKIN!'.tr(),
                      style: textTheme.displayMedium,
                    ),
                  ),
                _ => throw UnexpectedError(),
              })
          .toList(),
    );
  }
}
