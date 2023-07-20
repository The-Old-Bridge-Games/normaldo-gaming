import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.username,
    required this.highScore,
    required this.dollars,
  });

  final String username;
  final int highScore;
  final int dollars;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'high score'.tr(args: [highScore.toString()]),
          style: textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'dollars'.tr(args: [dollars.toString()]),
          style: textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
