import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';

import 'package:normaldo_gaming/ui/main_screen/widgets/new_level_dialog.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

enum Tabs {
  idle,
  basement,
  pizzeria,
  shop,
  trash,
  slots,
  settings,
  play;

  String get assetPath => switch (this) {
        Tabs.idle => 'assets/images/main_screen/a1.png',
        Tabs.basement => 'assets/images/main_screen/a3.png',
        Tabs.pizzeria => 'assets/images/main_screen/a4.png',
        Tabs.trash => 'assets/images/main_screen/a5.png',
        Tabs.shop => 'assets/images/main_screen/a6.png',
        Tabs.slots => 'assets/images/main_screen/a7.png',
        Tabs.settings => 'assets/images/main_screen/a8.png',
        Tabs.play => 'assets/images/main_screen/a9.png',
      };
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static void _newLevelListener(BuildContext context, UserState state) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final rewards =
        injector.get<LevelManager>().levelUpRewards[state.user.level - 1];
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => NewLevelDialog(
              reward: rewards,
              level: state.user.level,
            )).then((value) async {
      // Сделать зачисление призов
      context.read<UserCubit>().applyRewards(rewards);
    });
  }

  var _tab = Tabs.idle;
  set tab(Tabs newValue) {
    setState(() => _tab = newValue);
  }

  String get tabAsset => _tab.assetPath;

  void _onTrashBinPressed() {
    if (_tab == Tabs.trash) {
      // context.pushNamed(NGRoutes.pullUpGame.name).whenComplete(
      //       () => tab = Tabs.idle,
      //     );
    } else {
      tab = Tabs.trash;
    }
  }

  void _onStartPressed() {
    if (_tab == Tabs.play) {
      context.pushNamed(NGRoutes.pullUpGame.name).whenComplete(
            () => tab = Tabs.idle,
          );
    } else {
      tab = Tabs.play;
    }
  }

  void _onMissionsPressed() {
    if (_tab == Tabs.basement) {
      context
          .pushNamed(NGRoutes.basement.name)
          .whenComplete(() => tab = Tabs.idle);
    } else {
      tab = Tabs.basement;
    }
  }

  void _onSettingsPressed() {
    if (_tab == Tabs.settings) {
      // context
      //     .pushNamed(NGRoutes.settings.name)
      //     .whenComplete(() => tab = Tabs.idle);
    } else {
      tab = Tabs.settings;
    }
  }

  void _onShopPressed() {
    if (_tab == Tabs.shop) {
      context.pushNamed(NGRoutes.shop.name).whenComplete(
            () => tab = Tabs.idle,
          );
    } else {
      tab = Tabs.shop;
    }
  }

  void _onSlotsPressed() {
    if (_tab == Tabs.slots) {
      context
          .pushNamed(NGRoutes.slots.name)
          .whenComplete(() => tab = Tabs.idle);
    } else {
      tab = Tabs.slots;
    }
  }

  void _onKnowledgeBookPressed() {
    if (_tab == Tabs.pizzeria) {
      context.pushNamed(NGRoutes.knowledgeBook.name).whenComplete(
            () => tab = Tabs.idle,
          );
    } else {
      tab = Tabs.pizzeria;
    }
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

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      for (final tab in Tabs.values) {
        precacheImage(AssetImage(tab.assetPath), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => tab = Tabs.idle,
          child: BlocListener<UserCubit, UserState>(
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
                  _Background(tab: _tab),
                  Align(
                    alignment: const Alignment(-0.76, 0.18),
                    child: _buildStats(),
                  ),
                  Align(
                    alignment: const Alignment(-0.4, -0.25),
                    child: _buildMissionsHitbox(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildUserLevel(),
                  ),
                  Align(
                    alignment: const Alignment(0.12, 0.3),
                    child: _buildSlotsHitbox(),
                  ),
                  Align(
                    alignment: const Alignment(-0.1, 0.3),
                    child: _buildShopHitbox(),
                  ),
                  Align(
                    alignment: const Alignment(0.8, 0.4),
                    child: _buildPlayHitbox(),
                  ),
                  Align(
                    alignment: const Alignment(-0.27, 0.3),
                    child: _buildKnowledgeBookHitbox(),
                  ),
                  Align(
                    alignment: const Alignment(0.29, 0.4),
                    child: _buildSettingsHitbox(),
                  ),
                  Align(
                    alignment: const Alignment(-0.135, 0.48),
                    child: _buildTrashHitbox(),
                  ),
                  AnimatedAlign(
                    alignment: _tab == Tabs.idle
                        ? const Alignment(2, -1)
                        : const Alignment(1, -1),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut,
                    child: _buildNavigationClue(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrashHitbox() {
    return BouncingButton(
      onPressed: _onTrashBinPressed,
      child: Container(
        width: 22,
        height: 20,
        color: Colors.red.withOpacity(0.0001),
      ),
    );
  }

  Widget _buildNavigationClue() {
    const borderSide = BorderSide(
      width: 3,
      color: NGTheme.purple2,
    );
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => switch (_tab) {
        Tabs.idle => () {},
        Tabs.basement => _onMissionsPressed(),
        Tabs.pizzeria => _onKnowledgeBookPressed(),
        Tabs.play => _onStartPressed(),
        Tabs.settings => _onSettingsPressed(),
        Tabs.shop => _onShopPressed(),
        Tabs.slots => _onSlotsPressed(),
        Tabs.trash => _onTrashBinPressed(),
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 70,
        padding: const EdgeInsets.only(left: 32, top: 24, right: 32),
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(
            left: borderSide,
            bottom: borderSide,
          ),
        ),
        child: Text('${_tab.name.tr()}  >', style: textTheme.displayLarge),
      ),
    );
  }

  Widget _buildSettingsHitbox() {
    return BouncingButton(
      onPressed: _onSettingsPressed,
      child: Container(
        height: 70,
        width: 50,
        color: Colors.red.withOpacity(0.0001),
      ),
    );
  }

  Widget _buildKnowledgeBookHitbox() {
    return BouncingButton(
      onPressed: _onKnowledgeBookPressed,
      child: Container(
        width: 80,
        height: 100,
        color: Colors.red.withOpacity(0.0001),
      ),
    );
  }

  Widget _buildUserLevel() {
    final textTheme = Theme.of(context).textTheme;
    const borderSide = BorderSide(
      width: 3,
      color: NGTheme.purple2,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
          .add(const EdgeInsets.only(right: 32)),
      decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(
            bottom: borderSide,
            right: borderSide,
          )),
      child: UserLevelBar(
        levelManager: injector.get(),
        barWidth: 100,
        crossAxisAlignment: CrossAxisAlignment.end,
        rankStyle: textTheme.bodySmall,
        iconSize: 20,
      ),
    );
  }

  Widget _buildMissionsHitbox() {
    const dimension = 55.0;
    return BouncingButton(
      onPressed: _onMissionsPressed,
      child: Transform.rotate(
        angle: 1.1,
        child: Container(
          width: dimension,
          height: dimension,
          color: Colors.red.withOpacity(0.0001),
        ),
      ),
    );
  }

  Widget _buildStats() {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      final user = state.user;
      return Transform.rotate(
        angle: -0.35,
        child: SizedBox(
          width: 120,
          height: 60,
          // color: Colors.red.withOpacity(0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FittedBox(
                  child: Text(
                    user.name.isEmpty ? 'Loading...' : user.name,
                    style: textTheme.displayMedium,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 15,
                child: Row(
                  children: [
                    // HIGHSCORE
                    Image.asset('assets/images/pizza.png'),
                    const SizedBox(width: 4),
                    Text(
                      user.highScore.toString(),
                      style: textTheme.displaySmall,
                    ),
                    const Spacer(),
                    // DOLLARS
                    Image.asset('assets/images/dollar.png'),
                    const SizedBox(width: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        user.dollars.toString(),
                        style: textTheme.displaySmall,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 15,
                child: Row(
                  children: [
                    // EXTRA LIVES
                    Image.asset('assets/images/heart.png'),
                    const SizedBox(width: 4),
                    Text(
                      user.extraLives.toString(),
                      style: textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPlayHitbox() {
    return BouncingButton(
      onPressed: _onStartPressed,
      child: Container(
        width: 230,
        height: 90,
        color: Colors.red.withOpacity(0.0001),
      ),
    );
  }

  Widget _buildShopHitbox() {
    return BouncingButton(
      onPressed: _onShopPressed,
      child: Container(
        height: 100,
        width: 70,
        color: Colors.red.withOpacity(0.0001),
      ),
    );
  }

  Widget _buildSlotsHitbox() {
    const dimension = 85.0;
    return BouncingButton(
      onPressed: _onSlotsPressed,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.0001),
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({super.key, required this.tab});

  final Tabs tab;

  @override
  Widget build(BuildContext context) {
    const boxFit = BoxFit.fill;
    return Stack(
      fit: StackFit.expand,
      children: [
        Visibility(
            visible: tab == Tabs.idle,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.idle.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.basement,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.basement.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.pizzeria,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.pizzeria.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.play,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.play.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.settings,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.settings.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.shop,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.shop.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.slots,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.slots.assetPath,
              fit: boxFit,
            )),
        Visibility(
            visible: tab == Tabs.trash,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Image.asset(
              Tabs.trash.assetPath,
              fit: boxFit,
            )),
      ],
    );
  }
}
