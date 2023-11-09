import 'package:easy_localization/easy_localization.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/game/pull_up_game_onboarding1.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/widgets/liner_button.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  void _skip() {}
  void _nextStep() {}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: NGTheme.purple2, width: 3),
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Control NORMALDO!',
                          style: textTheme.displayLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "It's easy! Just hold&drag wherever your want!",
                          // 'It is very delicious and makes you more expreienced in this game and of cource more FATT!!!',
                          style: textTheme.displaySmall,
                        ),
                        Expanded(
                          child: BlocProvider<GameSessionCubit>(
                            create: (context) => injector.get(),
                            child: GameWidget(game: PullUpGameOnboarding1()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LinerButton(
                        side: LinerSide.left,
                        onPressed: _skip,
                        child: Text(
                          'I know..'.tr(),
                          style: textTheme.displaySmall,
                        ),
                      ),
                      LinerButton(
                        side: LinerSide.right,
                        onPressed: _nextStep,
                        child: Text(
                          '>>'.tr(),
                          style: textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
