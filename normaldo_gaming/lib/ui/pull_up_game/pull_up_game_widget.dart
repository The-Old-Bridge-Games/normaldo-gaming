import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';
import 'package:normaldo_gaming/ui/pull_up_game/widgets/pause_menu.dart';

import 'widgets/death_screen.dart';

class PullUpGameWidget extends StatefulWidget {
  const PullUpGameWidget({super.key});

  @override
  State<PullUpGameWidget> createState() => _PullUpGameWidgetState();
}

class _PullUpGameWidgetState extends State<PullUpGameWidget>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<GameSessionCubit>();
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        if (cubit.state.isDead) {
          break;
        }
        if (!cubit.state.paused) {
          cubit.togglePause();
        }
        break;
      case AppLifecycleState.resumed:
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GameWidget(
        game: PullUpGame(
          gameSessionCubit: context.read<GameSessionCubit>(),
        ),
        overlayBuilderMap: {
          Overlays.pauseMenu.name: (context, game) => const PauseMenu(),
          Overlays.deathScreen.name: (context, game) => const DeathScreen(),
        },
      ),
    );
  }
}
