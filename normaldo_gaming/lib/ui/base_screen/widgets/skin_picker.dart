import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/ui/widgets/ng_button.dart';
import 'package:normaldo_gaming/ui/widgets/wheel_scroll_view_x.dart';

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

class _SkinPickerState extends State<SkinPicker> with HasNgAudio {
  late final FixedExtentScrollController _controller;

  late int _currentPage;

  bool _pageSelectedBySkin(Skin skin) {
    return _currentPage == _indexOfSkin(skin);
  }

  bool _pageSelectedByUniqueId(String uniqueId) {
    return _currentPage == _indexOfUniqueId(uniqueId);
  }

  int _indexOfSkin(Skin skin) => widget._repository.mySkins.indexOf(skin);

  int _indexOfUniqueId(String uniqueId) =>
      widget._repository.mySkins.indexOf(widget._repository.mySkins
          .firstWhere((skin) => skin.uniqueId == uniqueId));

  String _rarityTitleOf(Skin skin) {
    return switch (skin.rarity) {
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

  void _selectSkin() {
    audio.playAudio(
        Random().nextBool()
            ? 'sfx/ui/SKIN AGREE.mp3'
            : 'sfx/ui/SKIN AGREE 2.mp3',
        volume: 1);
    context.read<UserCubit>().changeSkin(_skinFrom(_currentPage));
    context.pop();
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
    _controller.jumpToItem(_currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSkinId = context.read<UserCubit>().state.skin.uniqueId;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
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
                    audio.playAudio('sfx/button1.mp3', volume: 1);
                  },
                  builder: (context, index) {
                    final skin = widget._repository.mySkins[index];
                    return GestureDetector(
                      onTap: () {
                        final itemIndex = _indexOfSkin(skin);
                        if (itemIndex != _currentPage) {
                          _controller.animateToItem(
                            itemIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linearToEaseOut,
                          );
                        } else {
                          _selectSkin();
                        }
                      },
                      child: Column(
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
                                          color: NGTheme.colorOf(skin.rarity),
                                          blurRadius: 30,
                                          spreadRadius: -1,
                                        )
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 5,
                                        color: NGTheme.colorOf(skin.rarity)),
                                  ),
                                  height: 150,
                                  width: 150,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: RadialGradient(
                                              radius: 0.5,
                                              colors: [
                                                NGTheme.colorOf(skin.rarity),
                                                Colors.transparent,
                                              ],
                                            )),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                textAlign: TextAlign.center,
                                                style: NGTheme.rareSkinStyle
                                                    .copyWith(
                                                        color: NGTheme.colorOf(
                                                            skin.rarity)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Image.asset(
                                              'assets/images/${skin.assets.mask}',
                                              fit: BoxFit.cover,
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
                                                      .copyWith(
                                                          color: Colors.white),
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
                      ),
                    );
                  },
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                  flex: 2,
                  child: _pageSelectedByUniqueId(currentSkinId)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'SELECTED'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: NGTheme.green3,
                                ),
                          ),
                        )
                      : Center(
                          child: NGButton(
                            text: 'Select'.tr(),
                            onPressed: _selectSkin,
                          ),
                        )),
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
