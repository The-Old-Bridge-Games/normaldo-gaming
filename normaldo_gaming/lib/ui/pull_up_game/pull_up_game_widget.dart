import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class PullUpGameWidget extends StatelessWidget {
  const PullUpGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: PullUpGame(
        gameSessionCubit: context.read<GameSessionCubit>(),
      ),
    );
  }
}
