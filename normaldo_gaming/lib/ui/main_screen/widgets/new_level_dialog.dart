import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class NewLevelDialog extends StatelessWidget {
  const NewLevelDialog({
    required this.reward,
    required this.level,
    super.key,
  });

  final int reward;
  final int level;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          const SizedBox(height: 40),
          BlinkingText(
            'NEW LEVEL!',
            duration: const Duration(milliseconds: 500),
            endDelay: const Duration(seconds: 2),
            style: textTheme.displayLarge?.copyWith(fontSize: 48),
          ),
          const SizedBox(height: 32),
          Container(
            width: 200,
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
                  children: [
                    Image.asset(
                      'assets/images/star.png',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('+ $reward', style: textTheme.displayLarge),
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/images/dollar.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
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
}
