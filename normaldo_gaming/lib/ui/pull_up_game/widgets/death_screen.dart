import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class DeathScreen extends StatefulWidget {
  const DeathScreen({super.key});

  @override
  State<DeathScreen> createState() => _DeathScreenState();
}

class _DeathScreenState extends State<DeathScreen> with HasNgAudio {
  late final int _audioId;

  @override
  void initState() {
    super.initState();

    audio.loopAudio('death_audio.mp3').then((id) => _audioId = id);

    final gameCubit = context.read<GameSessionCubit>();
    final userCubit = context.read<UserCubit>();

    if (gameCubit.state.score > userCubit.state.score) {
      userCubit.changeHighScore(gameCubit.state.score);
    }
    userCubit.addDollars(gameCubit.state.dollars);
  }

  @override
  void dispose() {
    audio.stopAudio(_audioId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameSessionCubit>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: NGTheme.bgSemiBlack,
      body: Center(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red, width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'YOU DIED!',
                style: NGTheme.displayLarge.copyWith(color: Colors.red),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildScore(context, cubit.state.score),
                  const SizedBox(width: 16),
                  _buildDollars(context, cubit.state.dollars),
                ],
              ),
              const SizedBox(height: 32),
              BouncingButton(
                onPressed: () => context.pop(),
                child: Text('Menu', style: textTheme.displayMedium),
              ),
              const SizedBox(height: 8),
              BouncingButton(
                onPressed: () async {
                  await audio.stopBgm();
                  await audio.playBgm();
                  // ignore: use_build_context_synchronously
                  context.pushReplacement(NGRoutes.pullUpGame.path);
                },
                child: Text('Try again', style: textTheme.displayMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScore(BuildContext context, int score) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/pizza1.png',
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 4),
        Text(
          score.toString(),
          style: textTheme.displaySmall,
        )
      ],
    );
  }

  Widget _buildDollars(BuildContext context, int dollars) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/dollar.png',
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 4),
        Text(
          dollars.toString(),
          style: textTheme.displaySmall,
        )
      ],
    );
  }
}
