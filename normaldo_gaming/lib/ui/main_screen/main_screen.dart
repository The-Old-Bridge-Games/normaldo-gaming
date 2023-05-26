import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/user_info.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  AudioPlayer? _player;
  bool _isInGame = false;

  void _onStartPressed(BuildContext context) {
    _player?.stop();
    context.push(NGRoutes.pullUpGame.path).then((value) {
      if (value == 'try again') {
        _onStartPressed(context);
        return;
      }
      _isInGame = false;
      _startBgMusic();
    });
    _isInGame = true;
  }

  Future<void> _startBgMusic() async {
    _player = await FlameAudio.loopLongAudio('main_theme.mp3');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        _player?.pause();
        break;
      case AppLifecycleState.resumed:
        if (!_isInGame) {
          _player?.resume();
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    FlutterNativeSplash.remove();
    _startBgMusic();
  }

  @override
  void dispose() {
    _player?.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
                left: 48,
                top: 16,
                child: UserInfo(
                  username: state.name,
                  highScore: state.score,
                  dollars: state.dollars,
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
                      onPressed: () async {
                        _player?.stop();
                        context.read<UserCubit>().reset();
                        context.pop();
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
