import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_info.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _onStartPressed(BuildContext context) {
    context.goRoute(NGRoutes.pullUpGame);
  }

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/main_screen_background.png',
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 100,
              right: 150,
              child: _buildButtons(context),
            ),
            Positioned(
                left: 48,
                top: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfo(
                      username: state.user.name,
                      highScore: state.user.highScore,
                      dollars: state.user.dollars,
                    ),
                    const SizedBox(height: 8),
                    const LevelBar(),
                  ],
                )),
            Positioned(
                bottom: 20,
                left: 24,
                child: _buildResetButton(context, textTheme)),
          ],
        ),
      ),
    );
  }

  BouncingButton _buildResetButton(
    BuildContext context,
    TextTheme textTheme,
  ) {
    return BouncingButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('U wanna reset ya profile?'),
                  content: const Text('This operation is irreversible!'),
                  actions: [
                    ActionChip(
                      onPressed: () async {
                        context.pop();
                        context.read<UserCubit>().reset();
                      },
                      label: const Text('Yep',
                          style: TextStyle(color: Colors.red)),
                    ),
                    ActionChip(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: const Text('Nope'),
                    ),
                  ],
                ));
      },
      child: Text(
        'reset',
        style: textTheme.displayMedium,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BouncingButton(
            onPressed: () => _onStartPressed(context),
            child: Text(
              "Start",
              style: Theme.of(context).textTheme.displayLarge,
            ))
      ],
    );
  }
}

class LevelBar extends StatefulWidget {
  static const barWidth = 200.0;

  const LevelBar({super.key});

  @override
  State<LevelBar> createState() => _LevelBarState();
}

class _LevelBarState extends State<LevelBar> {
  static const _tag = 'missions_tag_1';
  static const _tag2 = 'missions_tag_2';

  final _levelManager = injector.get<LevelManager>();

  void _onMissionsPressed() {
    context.goNamed(NGRoutes.missions.name, queryParameters: {
      'tag': _tag,
      'tag2': _tag2,
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/star.png',
          fit: BoxFit.cover,
          height: 30,
          width: 30,
        ),
        const SizedBox(width: 8),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) => Text(
            '${state.user.level}',
            style: textTheme.displayMedium,
          ),
        ),
        const SizedBox(width: 16),
        BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          return Stack(
            children: [
              Container(
                width: LevelBar.barWidth,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  color: NGTheme.orange1,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                height: 25,
                width: _levelManager.isMaxLevel(state.user)
                    ? LevelBar.barWidth
                    : LevelBar.barWidth /
                        _levelManager.nextLevelExp(state.user) *
                        state.user.exp,
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 2,
                child: Text(
                  _levelManager.isMaxLevel(state.user)
                      ? 'max level'
                      : '${state.user.exp}/${_levelManager.nextLevelExp(state.user)}',
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall,
                ),
              )
            ],
          );
        }),
        const SizedBox(width: 8),
        BouncingButton(
          onPressed: _onMissionsPressed,
          child: Hero(
            tag: _tag,
            child: Image.asset(
              'assets/images/missions.png',
              fit: BoxFit.cover,
              width: 27,
              height: 27,
            ),
          ),
        ),
        Visibility(
          visible: false,
          child: BouncingButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              context.read<UserCubit>().addExp(30);
            },
          ),
        ),
      ],
    );
  }
}
