import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/mission_card.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/the_path.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final _levelManager = injector.get<LevelManager>();

  final _missionsExpandController = ExpandableController(initialExpanded: true);

  void _onChangeLocalePressed() {
    final currLocale = context.locale;
    final nextLocale = List.from(context.supportedLocales)..remove(currLocale);
    context.setLocale(nextLocale.first);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final user = context.read<UserCubit>().state.user;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        leading: BouncingButton(
          onPressed: () => context.pop(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '< back',
                style: textTheme.displaySmall,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('basement'.tr(), style: textTheme.displayLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name} ${_levelManager.rank(user).tr()}',
                      style: textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    UserLevelBar(
                      levelManager: _levelManager,
                      barWidth: screenSize.width / 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      barHeight: 20,
                      includeRank: false,
                    ),
                    const SizedBox(height: 16),
                    _buildMissions(),
                    const Spacer(),
                    BouncingButton(
                      onPressed: _onChangeLocalePressed,
                      child: Text(
                        'Language'.tr(
                          args: [context.locale.languageCode],
                        ),
                        style: textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLogoutButton(context, textTheme),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: ThePath(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BouncingButton _buildLogoutButton(
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
        'Sign out'.tr(),
        style: textTheme.displayMedium?.copyWith(color: Colors.red[900]),
      ),
    );
  }

  Widget _buildMissions() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _missionsExpandController.toggle()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Missions'.tr(),
                style: textTheme.displayMedium,
              ),
              const SizedBox(width: 16),
              AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: _missionsExpandController.value ? 0.25 : 0,
                child: Text('>',
                    style: textTheme.displayLarge?.copyWith(fontSize: 28)),
              ),
            ],
          ),
        ),
        Expandable(
          controller: _missionsExpandController,
          collapsed: const SizedBox.shrink(),
          expanded: SizedBox(
            height: 125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _levelManager.missions
                  .map((mission) =>
                      Expanded(child: MissionCard(mission: mission)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
