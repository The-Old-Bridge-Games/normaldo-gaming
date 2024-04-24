import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/daily_reward/cubit/daily_reward_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/core/widgets/blinking_widget.dart';

class TrashBinScreen extends StatelessWidget {
  const TrashBinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: BlocBuilder<DailyRewardCubit, DailyRewardState>(
          builder: (context, state) {
        if (state.canApply) {}
        return Column(
          children: [
            const SizedBox(height: 32),
            BlinkingText(
              'SUCCESS!!!'.tr(),
              duration: const Duration(milliseconds: 500),
              endDelay: const Duration(seconds: 2),
              style: textTheme.displayLarge?.copyWith(
                fontSize: 48,
                color: NGTheme.green3,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlinkingWidget(
                startDelay: const Duration(seconds: 1),
                endDelay: const Duration(hours: 2),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Text('You found:'.tr(), style: textTheme.displayLarge),
                    // Expanded(
                    // child: sta,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
