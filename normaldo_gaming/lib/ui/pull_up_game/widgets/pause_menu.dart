import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

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
                  border: Border.all(color: NGTheme.green1, width: 3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you sure??',
                      style: textTheme.displayLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'All game results will be dropped..',
                      style: textTheme.displaySmall,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionChip(
                            onPressed: () {
                              context.pop();
                              context.pop();
                            },
                            label: Text(
                              "let's do it!",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.red),
                            )),
                        const SizedBox(width: 8),
                        ActionChip(
                            onPressed: () => context.pop(),
                            label: Text(
                              "Nope",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: NGTheme.green1),
                            )),
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
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!_unpausing) _unpause();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Center(
            child: _unpausing
                ? Text((3 - _timer!.tick).toString(),
                    style: textTheme.displayLarge?.copyWith(fontSize: 32))
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: NGTheme.green1, width: 3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Paused',
                            style: textTheme.displayLarge
                                ?.copyWith(color: NGTheme.green1)),
                        const SizedBox(height: 32),
                        BouncingButton(
                          onPressed: _onMenuPressed,
                          child: Text('Menu', style: textTheme.displayMedium),
                        ),
                        const SizedBox(height: 8),
                        BouncingButton(
                          onPressed: _unpause,
                          child: Text('Back to gaaaame',
                              style: textTheme.displayMedium),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
