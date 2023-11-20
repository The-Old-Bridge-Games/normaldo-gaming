import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/missions/missions_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/missions/missions_list.dart';
import 'package:normaldo_gaming/ui/pull_up_game/widgets/mission_tile.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({
    required this.tag,
    super.key,
  });

  final String tag;

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            color: NGTheme.purple2,
            child: SafeArea(
              right: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 24),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                        child: Text(
                          'Missions'.tr(),
                          style: textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Hero(
                        tag: widget.tag,
                        child: Image.asset(
                          'assets/images/missions.png',
                          fit: BoxFit.cover,
                          width: 27,
                          height: 27,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: BouncingButton(
                          onPressed: () => context.pop(),
                          child: const Icon(
                            Icons.close,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: UserLevelBar(
                        levelManager: injector.get(), barWidth: 200),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(child: MissionsList())
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
            ),
          )
        ],
      ),
    );
  }
}
