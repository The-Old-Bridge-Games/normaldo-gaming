import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_info.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _onStartPressed(BuildContext context) {
    context.goRoute(NGRoutes.pullUpGame);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => Stack(
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
            Positioned(
                left: 24,
                top: 54,
                child: UserInfo(
                  username: state.name,
                  highScore: state.score,
                )),
            Positioned(
                bottom: 64,
                left: 24,
                child: _buildResetButton(context, textTheme))
          ],
        ),
      ),
    );
  }

  BouncingButton _buildResetButton(
    BuildContext context,
    TextTheme textTheme,
  ) {
    return BouncingButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('U wanna reset ya profile?'),
                  content: const Text('This operation is irreversible!'),
                  actions: [
                    ActionChip(
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<UserCubit>(context).reset();
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
        'reset',
        style: textTheme.displayMedium,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BouncingButton(
            onPressed: () => _onStartPressed(context),
            child: Text(
              "Start",
              style: Theme.of(context).textTheme.displayLarge,
            ))
      ],
    );
  }
}
