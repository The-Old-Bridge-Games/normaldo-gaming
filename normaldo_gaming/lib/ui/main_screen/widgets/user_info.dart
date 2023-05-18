import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.username,
    required this.highScore,
  });

  final String username;
  final int highScore;

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
        Text(
          'high score: $highScore',
          style: textTheme.displayMedium,
        ),
      ],
    );
  }
}
