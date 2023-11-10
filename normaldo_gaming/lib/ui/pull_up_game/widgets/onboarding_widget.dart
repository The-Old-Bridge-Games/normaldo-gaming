import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/pull_up_game_onboarding1.dart';
import 'package:normaldo_gaming/game/pull_up_game_onboarding2.dart';
import 'package:normaldo_gaming/game/pull_up_game_onboarding3.dart';
import 'package:normaldo_gaming/game/pull_up_game_onboarding4.dart';
import 'package:normaldo_gaming/game/pull_up_game_onboarding5.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/widgets/liner_button.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key, required this.game});

  final PullUpGame game;

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  final _pageController = PageController();

  int _activeIndex = 0;

  void _skip() {
    widget.game.overlays.remove(Overlays.onboarding.name);
    widget.game.resumeEngine();
    context.read<UserCubit>().educate();
  }

  void _prevStep() {
    if (_activeIndex == 0) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _nextStep() {
    if (_activeIndex == 4) _skip();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 32),
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NGTheme.purple2, width: 3),
            ),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: IgnorePointer(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: 5,
                        physics: const PageScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _activeIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return switch (index) {
                            0 => const _FirstPage(),
                            1 => const _SecondPage(),
                            2 => const _ThirdPage(),
                            3 => const _FourthPage(),
                            4 => const _FifthPage(),
                            _ => throw UnexpectedError(),
                          };
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LinerButton(
                          side: LinerSide.left,
                          onPressed: _activeIndex == 0
                              ? () => context.pop()
                              : _prevStep,
                          child: Text(
                            _activeIndex == 0 ? 'x' : '<',
                            style: textTheme.displaySmall,
                          ),
                        ),
                        _buildDots(_activeIndex),
                        LinerButton(
                          side: LinerSide.right,
                          onPressed: _nextStep,
                          child: Text(
                            _activeIndex == 4 ? '>>' : '>',
                            style: textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDots(int activeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(1, active: activeIndex == 0),
        const SizedBox(width: 8),
        _buildDot(2, active: activeIndex == 1),
        const SizedBox(width: 8),
        _buildDot(3, active: activeIndex == 2),
        const SizedBox(width: 8),
        _buildDot(4, active: activeIndex == 3),
        const SizedBox(width: 8),
        _buildDot(5, active: activeIndex == 4),
      ],
    );
  }

  Widget _buildDot(int index, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: active ? NGTheme.purple2 : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Text(
        index.toString(),
        style: NGTheme.bodySmall,
      ),
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Control',
                style: textTheme.displayLarge,
              ),
              Text(
                ' NORMALDO!',
                style: textTheme.displayLarge?.copyWith(color: NGTheme.green1),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "It's easy! Just hold&drag wherever your want!",
            textAlign: TextAlign.center,
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
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Eat',
                style: textTheme.displayLarge,
              ),
              Text(
                ' PIZZA!',
                style: textTheme.displayLarge?.copyWith(color: NGTheme.orange1),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "This is the foundation. Pizza is score and your universe provider!",
            textAlign: TextAlign.center,
            // 'It is very delicious and makes you more expreienced in this game and of cource more FATT!!!',
            style: textTheme.displaySmall,
          ),
          Expanded(
            child: BlocProvider<GameSessionCubit>(
              create: (context) => injector.get(),
              child: GameWidget(game: PullUpGameOnboarding2()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThirdPage extends StatelessWidget {
  const _ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dodge',
                style: textTheme.displayLarge,
              ),
              Text(
                ' TRASH!',
                style: textTheme.displayLarge?.copyWith(color: Colors.red[400]),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "There're a bunch of trash over here!! DODGE IT ALL!!",
            textAlign: TextAlign.center,
            // 'It is very delicious and makes you more expreienced in this game and of cource more FATT!!!',
            style: textTheme.displaySmall,
          ),
          Expanded(
            child: BlocProvider<GameSessionCubit>(
              create: (context) => injector.get(),
              child: GameWidget(game: PullUpGameOnboarding3()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FourthPage extends StatelessWidget {
  const _FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GET',
                style: textTheme.displayLarge,
              ),
              BlinkingText(
                ' FATTER!',
                duration: const Duration(milliseconds: 300),
                style: textTheme.displayLarge?.copyWith(color: NGTheme.green1),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Pizza makes you fatter bruh. Btw fat makes you SLOWER but HARDIER!! Be wise..",
            textAlign: TextAlign.center,
            style: textTheme.displaySmall,
          ),
          Expanded(
            child: BlocProvider<GameSessionCubit>(
              create: (context) => injector.get(),
              child: GameWidget(game: PullUpGameOnboarding4()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FifthPage extends StatelessWidget {
  const _FifthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CONSUUUMEEE!!!',
                style:
                    textTheme.displayLarge?.copyWith(color: NGTheme.auraBlue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Some items could be consumed.. But nobody sure what it supposed to do..",
            textAlign: TextAlign.center,
            style: textTheme.displaySmall,
          ),
          Expanded(
            child: BlocProvider<GameSessionCubit>(
              create: (context) => injector.get(),
              child: GameWidget(game: PullUpGameOnboarding5()),
            ),
          ),
        ],
      ),
    );
  }
}
