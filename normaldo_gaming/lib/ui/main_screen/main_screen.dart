import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';

import 'package:normaldo_gaming/ui/main_screen/widgets/new_level_dialog.dart';
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

  void _onStartPressed() {
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

  void _onSlotsPressed() {
    context.pushNamed(NGRoutes.slots.name);
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
                  'assets/images/nrmld_back.png',
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: const Alignment(-0.76, 0.18),
                  child: _buildStats(),
                ),
                Align(
                  alignment: const Alignment(-0.4, -0.25),
                  child: _buildMissionsHitbox(),
                ),
                Align(
                  alignment: Alignment.topRight,
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
                  alignment: const Alignment(-0.27, 0.4),
                  child: _buildKnowledgeBookHitbox(),
                ),
                Align(
                  alignment: const Alignment(0.29, 0.4),
                  child: _buildSettingsHitbox(),
                ),
              ],
            ),
          ),
        ),
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
        width: 75,
        height: 90,
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
          border: Border(
        bottom: borderSide,
        left: borderSide,
      )),
      child: UserLevelBar(
        levelManager: injector.get(),
        barWidth: 100,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Text(
                  user.name,
                  style: textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 15,
                child: Row(
                  children: [
                    // HIGHSCORE
                    Image.asset('assets/images/pizza.png'),
                    const SizedBox(width: 2),
                    Text(
                      user.highScore.toString(),
                      style: textTheme.labelSmall,
                    ),
                    const SizedBox(width: 8),
                    // DOLLARS
                    Image.asset('assets/images/dollar.png'),
                    const SizedBox(width: 2),
                    Text(
                      user.dollars.toString(),
                      style: textTheme.labelSmall,
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
                    const SizedBox(width: 2),
                    Text(
                      user.highScore.toString(),
                      style: textTheme.labelSmall,
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
        width: 200,
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
    const dimension = 75.0;
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
