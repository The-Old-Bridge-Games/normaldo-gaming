import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/theme.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: NGTheme.purple3, width: 3),
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Pick pizza!',
                  style: textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'It is very delicious and makes you more expreienced in this game and of cource more FATT!!!',
                  style: textTheme.displaySmall,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
