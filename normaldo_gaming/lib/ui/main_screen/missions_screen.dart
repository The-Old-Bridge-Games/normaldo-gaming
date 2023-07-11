import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/main_screen/main_screen.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({
    required this.tag,
    super.key,
  });

  final String tag;

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  final _levelManager = injector.get<LevelManager>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            color: NGTheme.purple1,
            child: SafeArea(
              right: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 24),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                        child: Text(
                          'Missions',
                          style: textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Hero(
                        tag: widget.tag,
                        child: Image.asset(
                          'assets/images/missions.png',
                          fit: BoxFit.cover,
                          width: 27,
                          height: 27,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: BouncingButton(
                          onPressed: () => context.pop(),
                          child: const Icon(
                            Icons.close,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
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
                        BlocBuilder<UserCubit, UserState>(
                            builder: (context, state) {
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          itemCount: _levelManager.missions.length,
                          itemBuilder: (context, index) => Card(
                                color: NGTheme.purple2,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: _buildIcon(
                                          _levelManager.missions[index].exp),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _levelManager
                                            .missions[index].description,
                                        style: textTheme.bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                  ],
                                ),
                              )),
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(int exp) {
    Widget iconWrapper(String asset) {
      return Image.asset(
        asset,
        fit: BoxFit.cover,
        width: 25,
        height: 25,
      );
    }

    return switch (exp) {
      1 => iconWrapper('assets/images/star.png'),
      2 => iconWrapper('assets/images/two_stars.png'),
      3 => iconWrapper('assets/images/three_stars.png'),
      _ => throw UnexpectedError(),
    };
  }
}
