import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/new_level_dialog.dart';
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

  static void _newLevelListener(BuildContext context, UserState state) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => NewLevelDialog(
              reward: state.user.level * 10,
              level: state.user.level,
            )).then((value) async {
      context.read<UserCubit>().addDollars(state.user.level * 10);
    });
  }

  void _onStartPressed(BuildContext context) {
    context.pushNamed(NGRoutes.pullUpGame.name);
  }

  void _onMissionsPressed() {
    context.pushNamed(NGRoutes.missions.name, extra: {
      'tag': _tag,
      'tag2': _tag2,
    });
  }

  void _onSettingsPressed() {
    context.pushNamed(NGRoutes.settings.name);
  }

  void _onShopPressed() {
    context.pushNamed(NGRoutes.shop.name);
  }

  void _onKnowledgeBookPressed() {
    context.pushNamed(NGRoutes.knowledgeBook.name);
  }

  void _failureListener(BuildContext context, UserState state) {
    if (state.failure?.statusCode == HttpStatus.unauthorized) {
      context.read<AuthCubit>().logout();
    }
  }

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
    context.read<UserCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocListener<UserCubit, UserState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure,
          listener: _failureListener,
          child: BlocConsumer<UserCubit, UserState>(
            listenWhen: (previous, current) =>
                previous.user.level < current.user.level,
            listener: _newLevelListener,
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
                ),
                Align(
                  alignment: const Alignment(-0, 1),
                  child: _buildShopButton(),
                ),
                Align(
                  alignment: const Alignment(0.9, 0),
                  child: _buildKnowledgeBookButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKnowledgeBookButton() {
    return BouncingButton(
      onPressed: _onKnowledgeBookPressed,
      child: Image.asset(
        'assets/images/knowledge_book.png',
        height: 55,
        width: 39,
      ),
    );
  }

  Widget _buildShopButton() {
    return BouncingButton(
        onPressed: _onShopPressed,
        child: Image.asset(
          'assets/images/shop.png',
          height: 100,
          width: 100,
        ));
  }

  Widget _buildSlotMachineButton() {
    return BouncingButton(
      onPressed: () => context.pushNamed(NGRoutes.slots.name),
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
                  title: Text('Are you sure?'.tr()),
                  content: Text("You're going to logout your account".tr()),
                  actions: [
                    ActionChip(
                      onPressed: () async {
                        context.pop();
                        context.read<AuthCubit>().logout();
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
