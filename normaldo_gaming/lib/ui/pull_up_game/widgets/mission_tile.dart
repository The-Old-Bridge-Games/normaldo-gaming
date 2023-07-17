import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';

class MissionTile extends StatelessWidget {
  static const height = 55.0;

  const MissionTile({
    required this.mission,
    this.progressText,
    super.key,
  });

  final Mission mission;
  final String? progressText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: NGTheme.purple2,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildIcon(),
            ),
            Expanded(
              child: Text(
                progressText == null
                    ? mission.description
                    : '${mission.description} $progressText',
                style: textTheme.bodySmall?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    Widget iconWrapper(String asset) {
      return Image.asset(
        asset,
        fit: BoxFit.cover,
        width: 25,
        height: 25,
      );
    }

    final starsIcons = switch (mission.exp) {
      1 => iconWrapper('assets/images/star.png'),
      2 => iconWrapper('assets/images/two_stars.png'),
      3 => iconWrapper('assets/images/three_stars.png'),
      _ => throw UnexpectedError(),
    };

    if (mission.completed) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          starsIcons,
          Positioned(
            bottom: -4,
            right: -4,
            child: Image.asset(
              'assets/images/checkmark.png',
              width: 25,
              height: 18,
            ),
          ),
        ],
      );
    } else {
      return starsIcons;
    }
  }
}
