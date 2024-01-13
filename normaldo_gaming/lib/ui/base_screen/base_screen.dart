import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/mission_card.dart';
import 'package:normaldo_gaming/ui/base_screen/widgets/the_path.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';
import 'package:normaldo_gaming/ui/widgets/ng_button.dart';

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
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
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
                    Row(
                      children: [
                        _buildSkin(skin),
                        Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              barHeight: 20,
                              includeRank: false,
                            ),
                          ],
                        ),
                      ],
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

  GestureDetector _buildSkin(Skin skin) {
    return GestureDetector(
      onTap: () {
        final skinsRepo = injector.get<SkinsRepository>(key: 'skins_test');
        showDialog(
            context: context,
            useSafeArea: false,
            builder: (context) {
              return SkinPicker(skinsRepo);
            }).whenComplete(() => setState(() {}));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 50,
              spreadRadius: 5,
            )
          ],
          image: DecorationImage(
            image: AssetImage('assets/images/${skin.assets.skinny}'),
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

class SkinPicker extends StatefulWidget {
  const SkinPicker(
    this._repository, {
    this.initId,
    super.key,
  });

  final SkinsRepository _repository;
  final String? initId;

  @override
  State<SkinPicker> createState() => _SkinPickerState();
}

class _SkinPickerState extends State<SkinPicker> {
  late final FixedExtentScrollController _controller;

  late int _currentPage;

  bool _pageSelected(int index) {
    return _currentPage == index;
  }

  bool _pageSelectedBySkin(Skin skin) {
    return _currentPage == _indexOfSkin(skin);
  }

  int _indexOfSkin(Skin skin) => widget._repository.mySkins.indexOf(skin);

  Color _colorOf(Skin skin) {
    return switch (skin.rarity) {
      SkinRarity.classic => NGTheme.classicSkin,
      SkinRarity.common => NGTheme.commonSkin,
      SkinRarity.rare => NGTheme.rareSkin,
      SkinRarity.epic => NGTheme.epicSkin,
      SkinRarity.legendary => NGTheme.legendarySkin,
    };
  }

  String _rarityTitleOf(Skin skin) {
    return switch (skin.rarity) {
      // TODO – localizations
      SkinRarity.classic => 'CLASSIC'.tr(),
      SkinRarity.common => 'COMMON'.tr(),
      SkinRarity.rare => 'RARE'.tr(),
      SkinRarity.epic => 'EPIC'.tr(),
      SkinRarity.legendary => 'LEGENDARY'.tr(),
    };
  }

  Skin _skinFrom(int page) {
    return widget._repository.mySkins[page];
  }

  @override
  void initState() {
    if (widget.initId != null) {
      final skin = widget._repository.mySkins
          .firstWhere((element) => element.uniqueId == widget.initId);
      _currentPage = widget._repository.mySkins.indexOf(skin);
    } else {
      _currentPage = 0;
    }
    _controller = FixedExtentScrollController(
      initialItem: _currentPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSkinId = context.read<UserCubit>().state.skin.uniqueId;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          const Spacer(flex: 2),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: ListWheelScrollViewX(
              itemExtent: 180,
              itemCount: widget._repository.mySkins.length,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              onSelectedItemChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              builder: (context, index) {
                final skin = widget._repository.mySkins[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Center(
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linearToEaseOut,
                          scale: _pageSelectedBySkin(skin) ? 1.3 : 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                if (_pageSelectedBySkin(skin))
                                  BoxShadow(
                                    color: _colorOf(skin),
                                    blurRadius: 100,
                                    spreadRadius: 10,
                                  )
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(width: 5, color: _colorOf(skin)),
                            ),
                            height: 150,
                            width: 150,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        radius: 0.5,
                                        colors: [
                                          _colorOf(skin),
                                          Colors.transparent,
                                        ],
                                      )),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 4)
                                          .add(EdgeInsets.only(
                                              top: skin.rarity ==
                                                      SkinRarity.legendary
                                                  ? 4
                                                  : 0)),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          _rarityTitleOf(skin),
                                          style: NGTheme.rareSkinStyle
                                              .copyWith(color: _colorOf(skin)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Image.asset(
                                        'assets/images/${skin.assets.mask}',
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            skin.name.tr(),
                                            style: NGTheme.displaySmall
                                                .copyWith(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Spacer(),
          NGButton(
              text: 'Select'.tr(),
              onPressed: () {
                context.read<UserCubit>().changeSkin(_skinFrom(_currentPage));
                context.pop();
              }),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

class ListWheelScrollViewX extends StatelessWidget {
  final Widget Function(BuildContext, int) builder;
  final Axis scrollDirection;
  final FixedExtentScrollController? controller;
  final double itemExtent;
  final double diameterRatio;
  final void Function(int)? onSelectedItemChanged;
  final int itemCount;
  const ListWheelScrollViewX({
    super.key,
    required this.builder,
    required this.itemExtent,
    required this.itemCount,
    this.controller,
    this.onSelectedItemChanged,
    this.scrollDirection = Axis.vertical,
    this.diameterRatio = 100000,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: scrollDirection == Axis.horizontal ? 3 : 0,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: onSelectedItemChanged,
        controller: controller,
        itemExtent: itemExtent,
        renderChildrenOutsideViewport: true,
        clipBehavior: Clip.none,
        diameterRatio: diameterRatio,
        physics: const FixedExtentScrollPhysics(),
        squeeze: 0.9,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            return RotatedBox(
              quarterTurns: scrollDirection == Axis.horizontal ? 1 : 0,
              child: builder(context, index),
            );
          },
        ),
      ),
    );
  }
}
