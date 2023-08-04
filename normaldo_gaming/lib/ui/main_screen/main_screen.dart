import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_info.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _tag = 'missions_tag_1';
  static const _tag2 = 'missions_tag_2';

  void _onStartPressed(BuildContext context) {
    context.goRoute(NGRoutes.pullUpGame);
  }

  void _onMissionsPressed() {
    context.goNamed(NGRoutes.missions.name, queryParameters: {
      'tag': _tag,
      'tag2': _tag2,
    });
  }

  void _onSettingsPressed() {
    context.goNamed(NGRoutes.settings.name);
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
        bloc: context.read(),
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
                      extraLives: state.user.extraLives,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UserLevelBar(
                          levelManager: injector.get(),
                          barWidth: 200,
                        ),
                        const SizedBox(width: 8),
                        BouncingButton(
                            onPressed: _onMissionsPressed,
                            child: Hero(
                              tag: _tag,
                              child: Image.asset(
                                'assets/images/missions.png',
                                height: 26,
                                width: 26,
                              ),
                            ))
                      ],
                    ),
                  ],
                )),
            Positioned(
                bottom: 20,
                left: 24,
                child: _buildResetButton(context, textTheme)),
            Positioned(
                right: 32,
                top: 32,
                child: BouncingButton(
                  onPressed: _onSettingsPressed,
                  child: Image.asset(
                    'assets/images/gear.png',
                    height: 35,
                    width: 35,
                  ),
                )),
            Align(
              alignment: const Alignment(-0.6, 1),
              child: _buildSlotMachineButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlotMachineButton() {
    return BouncingButton(
      onPressed: () => context.goNamed(NGRoutes.slots.name),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/slot_machine.png',
            width: 80,
            height: 160,
            fit: BoxFit.contain,
          ),
          Positioned(
              top: 42,
              left: 22,
              child: Image.asset(
                'assets/images/normaldo/normaldo2.png',
                width: 30,
                height: 30,
              ))
        ],
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
                  title: Text('U wanna reset ya profile?'.tr()),
                  content: Text('This operation is irreversible!'.tr()),
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
              'Start'.tr(),
              style: Theme.of(context).textTheme.displayLarge,
            ))
      ],
    );
  }
}
