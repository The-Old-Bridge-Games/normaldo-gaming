import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/slot_machine/cubit/slot_machine_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/components/slot_machine_widget.dart';
import 'package:normaldo_gaming/domain/roller/rolls.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_level_bar.dart';
import 'package:normaldo_gaming/ui/slot_machine/widgets/bid_widget.dart';
import 'package:normaldo_gaming/ui/slot_machine/widgets/slot_win_dialog.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class SlotMachineScreen extends StatefulWidget {
  const SlotMachineScreen({super.key});

  @override
  State<SlotMachineScreen> createState() => _SlotMachineScreenState();
}

class _SlotMachineScreenState extends State<SlotMachineScreen> {
  late final SlotMachineController _controller;

  final _rollItems = <Rolls, RollItem>{
    Rolls.exp1: RollItem(
      index: 0,
      child: Image.asset('assets/images/star.png'),
    ),
    Rolls.exp2: RollItem(
      index: 1,
      child: Image.asset('assets/images/two_stars.png'),
    ),
    Rolls.exp3: RollItem(
      index: 2,
      child: Image.asset('assets/images/three_stars.png'),
    ),
    Rolls.extraLife: RollItem(
      index: 3,
      child: Image.asset('assets/images/heart.png'),
    ),
    Rolls.half1: RollItem(
      index: 4,
      child: Image.asset('assets/images/cocktail.png'),
    ),
    Rolls.win: RollItem(
      index: 5,
      child: Image.asset('assets/images/dollar.png'),
    ),
    Rolls.jackpot: RollItem(
      index: 6,
      child: Image.asset('assets/images/pizza.png'),
    ),
  };

  dynamic _onCreated(SlotMachineController controller) async {
    _controller = controller;
    _controller.start(hitRollItemIndex: null);
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.stop(reelIndex: 0);
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.stop(reelIndex: 1);
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.stop(reelIndex: 2);
  }

  Future<void> _onSpinPressed() async {
    final cubit = context.read<SlotMachineCubit>();
    cubit.roll();
  }

  Future<void> _slotsListener(
      BuildContext context, SlotMachineState state) async {
    final cubit = context.read<SlotMachineCubit>();
    final userCubit = context.read<UserCubit>();

    if (state.winRoll != null) {
      final winRoll = state.winRoll!;
      userCubit.takeDollars(state.bid);
      if (state.winRoll == Rolls.empty) {
        _controller.start(hitRollItemIndex: null);
      } else {
        _controller.start(hitRollItemIndex: _rollItems[winRoll]?.index);
      }
      await Future.delayed(Duration(seconds: 1 + Random().nextInt(3)));
      _controller.stop(reelIndex: 0);
      await Future.delayed(Duration(milliseconds: 100 + Random().nextInt(900)));
      _controller.stop(reelIndex: 1);
      await Future.delayed(Duration(milliseconds: 100 + Random().nextInt(900)));
      _controller.stop(reelIndex: 2);
      await Future.delayed(const Duration(milliseconds: 1000));
      cubit.stopSpin();
      if (winRoll != Rolls.empty) {
        // ignore: use_build_context_synchronously
        await showDialog(
          context: context,
          builder: (context) => SlotWinDialog(
            winRoll: winRoll,
            bid: state.bid,
          ),
        );
      }
      _applyWin(winRoll, state.bid);
    }
  }

  void _applyWin(Rolls winRoll, int bid) {
    final userCubit = context.read<UserCubit>();
    switch (winRoll) {
      case Rolls.empty:
        break;
      case Rolls.exp1:
        userCubit.addExp(1);
      case Rolls.exp2:
        userCubit.addExp(2);
      case Rolls.exp3:
        userCubit.addExp(3);
      case Rolls.extraLife:
        userCubit.addExtraLife(1);
      case Rolls.half1:
        userCubit.addDollars(bid ~/ 2);
      case Rolls.win:
        userCubit.addDollars(bid * 10);
      case Rolls.jackpot:
        userCubit.addDollars(bid * 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        if (context.read<SlotMachineCubit>().state.spinning) {
          return false;
        }
        return true;
      },
      child: BlocListener<SlotMachineCubit, SlotMachineState>(
        listener: _slotsListener,
        listenWhen: (previous, current) => previous.winRoll != current.winRoll,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<SlotMachineCubit, SlotMachineState>(
              builder: (context, state) {
            return Stack(
              children: [
                Visibility(
                  visible: !state.spinning,
                  child: Positioned(
                    top: 24,
                    left: 24,
                    child: _buildBackButton(),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 64,
                  child: _buildBalance(),
                ),
                Positioned(
                  top: 120,
                  left: 64,
                  child: _buildExtraLives(),
                ),
                Positioned(
                  top: 240,
                  right: 20,
                  child: IgnorePointer(
                    ignoring: state.spinning,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: state.spinning ? 0.5 : 1,
                      child: BidWidget(
                        onBidChanged: (bid) {
                          context.read<SlotMachineCubit>().changeBid(bid: bid);
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, -0.89),
                  child: UserLevelBar(
                    levelManager: injector.get(),
                    barWidth: 300,
                  ),
                ),
                _buildSlotMachine(),
                Positioned(
                  right: -20,
                  top: 180,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 48),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: state.spinning ? 0.5 : 1,
                      child: BouncingButton(
                        onPressed: state.spinning ||
                                context.read<UserCubit>().state.user.dollars <
                                    state.bid
                            ? null
                            : _onSpinPressed,
                        child: Text(
                          'Spin'.tr(),
                          style: textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSlotMachine() {
    return Positioned(
      bottom: 0,
      right: 100,
      left: 100,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/slot_machine.png',
                height: 300,
                width: 150,
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/slot_machine.png',
                height: 300,
                width: 150,
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/slot_machine.png',
                height: 300,
                width: 150,
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: (300 * 0.272)),
              child: IgnorePointer(
                child: SlotMachineWidget(
                  shuffle: false,
                  height: 57,
                  reelSpacing: 90,
                  width: 400,
                  reelItemExtent: 50,
                  rollItems: _rollItems.values.toList(),
                  onCreated: _onCreated,
                  onFinished: (resultIndexes) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraLives() {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset('assets/images/heart.png', width: 30, height: 30),
            const SizedBox(width: 8),
            Text(state.user.extraLives.toString(),
                style: textTheme.displayMedium),
          ],
        );
      },
    );
  }

  Widget _buildBackButton() {
    final textTheme = Theme.of(context).textTheme;
    return BouncingButton(
        onPressed: () => context.pop(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chevron_left, size: 30, color: Colors.white),
            const SizedBox(width: 4),
            Text('Back'.tr(), style: textTheme.displayLarge)
          ],
        ));
  }

  Widget _buildBalance() {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset('assets/images/dollar.png', width: 30, height: 30),
          const SizedBox(width: 8),
          Text(state.user.dollars.toString(), style: textTheme.displayMedium),
        ],
      );
    });
  }
}
