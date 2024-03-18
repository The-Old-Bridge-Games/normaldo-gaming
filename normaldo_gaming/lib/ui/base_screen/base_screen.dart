import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/mission/mission_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/mission_card.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/skin_picker.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/the_path.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/pull_up_game/widgets/mission_tile.dart';
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
    final cubit = context.read<UserCubit>();
    final user = cubit.state.user;
    final skin = cubit.state.skin;
    return GestureDetector(
      onDoubleTap: () {
        context.read<UserCubit>().addExp(10);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBackButton(context, textTheme),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            // Skin&Level
                            Card(
                              color: NGTheme.purple2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: NGTheme.purple3,
                                    width: 4,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Expanded(child: _buildSkin(skin)),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${user.name} ${_levelManager.rank(user).tr()}',
                                            style: textTheme.displaySmall,
                                          ),
                                          const SizedBox(height: 8),
                                          UserLevelBar(
                                            levelManager: _levelManager,
                                            barWidth: screenSize.width / 4,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            barHeight: 20,
                                            includeRank: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            _buildMissions(),
                            // const SizedBox(height: 16),
                            // BouncingButton(
                            //   onPressed: _onChangeLocalePressed,
                            //   child: Text(
                            //     'Language'.tr(
                            //       args: [context.locale.languageCode],
                            //     ),
                            //     style: textTheme.displayMedium,
                            //   ),
                            // ),
                            // const SizedBox(height: 16),
                            // _buildLogoutButton(context, textTheme),
                            // const SizedBox(height: 16),
                          ],
                        ),
                      ),
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
      ),
    );
  }

  BouncingButton _buildBackButton(BuildContext context, TextTheme textTheme) {
    return BouncingButton(
      onPressed: () => context.pop(),
      child: Text(
        '< back',
        style: textTheme.displaySmall,
      ),
    );
  }

  GestureDetector _buildSkin(Skin skin) {
    const dimension = 80.0;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            useSafeArea: false,
            barrierColor: Colors.black87,
            builder: (context) {
              return SkinPicker(
                initId: skin.uniqueId,
              );
            }).whenComplete(() => setState(() {}));
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                clipBehavior: Clip.none,
                height: dimension,
                width: dimension,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      radius: 0.5,
                      colors: [
                        NGTheme.colorOf(skin.rarity),
                        NGTheme.purple2,
                      ],
                    )),
              ),
              Container(
                width: dimension * 0.8,
                height: dimension * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/${skin.assets.mask}'),
                  ),
                ),
              ),
            ],
          ),
        ],
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
                        // context.read<AuthCubit>().logout();
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
    return Card(
      color: NGTheme.purple2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: NGTheme.purple3,
            width: 4,
          )),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: GestureDetector(
                onTap: () => setState(() => _missionsExpandController.toggle()),
                child: Text(
                  'Missions'.tr(),
                  style: textTheme.displayMedium,
                ),
              ),
            ),
            BlocBuilder<MissionCubit, MissionState>(builder: (context, state) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.missions.length,
                  itemBuilder: (context, index) {
                    final mission = state.missions.toList()[index];
                    return MissionTile(mission: mission);
                  });
            }),
          ],
        ),
      ),
    );
  }
}
