import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/components/slot_machine_widget.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class SlotMachineScreen extends StatefulWidget {
  const SlotMachineScreen({super.key});

  @override
  State<SlotMachineScreen> createState() => _SlotMachineScreenState();
}

class _SlotMachineScreenState extends State<SlotMachineScreen> {
  late final SlotMachineController _controller;

  final _rollItems = [
    RollItem(
      index: 0,
      child: Image.asset('assets/images/cocktail.png'),
    ),
    RollItem(
      index: 1,
      child: Image.asset('assets/images/trash_bin.png'),
    ),
    RollItem(
      index: 2,
      child: Image.asset('assets/images/dollar.png'),
    ),
    RollItem(
      index: 3,
      child: Image.asset('assets/images/heart.png'),
    ),
  ];

  dynamic _onCreated(SlotMachineController controller) {
    _controller = controller;
    _controller.stop(reelIndex: 0);
  }

  Future<void> _onSpinPressed() async {
    _controller.start(hitRollItemIndex: null);
    await Future.delayed(const Duration(seconds: 2));
    _controller.stop(reelIndex: 0);
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.stop(reelIndex: 1);
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.stop(reelIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Row(
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
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SlotMachineWidget(
                height: 57,
                reelSpacing: 90,
                width: 400,
                reelItemExtent: 50,
                rollItems: _rollItems,
                onCreated: _onCreated,
                onFinished: (resultIndexes) {
                  print('Result: $resultIndexes');
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 48),
              child: BouncingButton(
                onPressed: _onSpinPressed,
                child: Text(
                  'Spin',
                  style: textTheme.displayLarge,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
