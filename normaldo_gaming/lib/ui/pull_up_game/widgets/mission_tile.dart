import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/game/utils/mission_tr_ext.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MissionTile extends StatefulWidget {
  static const height = 55.0;

  const MissionTile({
    required this.mission,
    this.progressText,
    this.canSkipWithAd = true,
    this.onSkippedByAd,
    super.key,
  });

  final Mission mission;
  final bool canSkipWithAd;
  final VoidCallback? onSkippedByAd;
  final String? progressText;

  @override
  State<MissionTile> createState() => _MissionTileState();
}

class _MissionTileState extends State<MissionTile>
    with SingleTickerProviderStateMixin {
  late Mission _mission;

  void _onSkipPressed() {
    // context.read<AdsCubit>().showAd(
    //     type: AdType.rewarded,
    //     onComplete: () {
    //       widget.onSkippedByAd?.call();
    //     });
    widget.onSkippedByAd?.call();
  }

  @override
  void initState() {
    super.initState();

    _mission = widget.mission;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: widget.mission.completed ? Colors.green[400] : NGTheme.purple1,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: MissionTile.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildIcon(),
                ),
                Expanded(
                  child: Text(
                    widget.progressText == null
                        ? _mission.trDescription()
                        : '${widget.mission.trDescription()} ${widget.progressText}',
                    style: textTheme.bodySmall?.copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
            if (widget.canSkipWithAd)
              Positioned(
                bottom: 2,
                right: 2,
                child: _buildAddSkipButton(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddSkipButton() {
    return BouncingButton(
      onPressed: _onSkipPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: NGTheme.purple3,
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Icon(
          Icons.skip_next_rounded,
          size: 16,
          color: Colors.white,
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

    final starsIcons = switch (_mission.exp) {
      1 => iconWrapper('assets/images/pizza_pack1.png'),
      2 => iconWrapper('assets/images/pizza_pack2.png'),
      3 => iconWrapper('assets/images/pizza_pack3.png'),
      _ => throw UnexpectedError(),
    };

    return starsIcons;
  }
}
