import 'package:flutter/material.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BouncingButton(
            onPressed: () {
              print('Game Started..');
            },
            child: Text(
              "Start",
              style: Theme.of(context).textTheme.displayLarge,
            ))
      ],
    );
  }
}
