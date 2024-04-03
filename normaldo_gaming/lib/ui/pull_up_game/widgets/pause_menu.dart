import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/ui/missions/missions_list.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';
import 'package:normaldo_gaming/ui/widgets/ng_button.dart';

class PauseMenu extends StatefulWidget {
  const PauseMenu({super.key});

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  bool _unpausing = false;
  Timer? _timer;

  void _unpause() {
    setState(() => _unpausing = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 3) {
        timer.cancel();
        context.read<GameSessionCubit>().togglePause();
      } else {
        setState(() {});
      }
    });
  }

  void _onMenuPressed() {
    final textTheme = Theme.of(context).textTheme;
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: NGTheme.purple2, width: 3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'U sure??'.tr(),
                      style: textTheme.displayLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'All game results will be dropped..'.tr(),
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Vibrate.feedback(FeedbackType.light);
                              context.pop();
                            },
                            child: Text(
                              'Back to game'.tr(),
                              style: textTheme.displaySmall,
                            )),
                        const SizedBox(width: 8),
                        NGButton(
                          onPressed: () {
                            Vibrate.feedback(FeedbackType.light);
                            context.pop();
                            context.pop();
                          },
                          text: 'Exit'.tr(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: NGTheme.bgSemiBlack,
      body: _unpausing
          ? Center(
              child: Text((3 - _timer!.tick).toString(),
                  style: textTheme.displayLarge?.copyWith(fontSize: 64)),
            )
          : SafeArea(
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        MissionsList(
                          disabled: true,
                          showProgress: true,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: NGTheme.purple2, width: 3),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Paused'.tr(),
                                  style: textTheme.displayLarge
                                      ?.copyWith(color: NGTheme.purple2)),
                              const SizedBox(height: 32),
                              BouncingButton(
                                onPressed: _onMenuPressed,
                                child: Text(
                                  'Menu'.tr(),
                                  style: textTheme.displayMedium,
                                ),
                              ),
                              const SizedBox(height: 16),
                              NGButton(
                                onPressed: _unpause,
                                text: 'Resume'.tr(),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !_unpausing,
                          child: const SizedBox(height: 32),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
