import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class NgAudioWidget extends StatefulWidget {
  const NgAudioWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<NgAudioWidget> createState() => _NgAudioWidgetState();
}

class _NgAudioWidgetState extends State<NgAudioWidget>
    with WidgetsBindingObserver {
  final _audio = injector.get<NgAudio>();

  String get location {
    if (!mounted) return '';
    return GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        _audio.pauseBgm();
        break;
      case AppLifecycleState.resumed:
        if (location == '/') {
          _audio.resumeBgm();
        }
        break;
    }
  }

  Future<void> _startPullUpGameBgm() async {
    _audio.clearBgm();
    _audio.addAllToBgm([
      'main_theme.mp3',
      'hard_track.mp3',
      'club_track.mp3',
    ]);
    _audio.playBgm();
  }

  Future<void> _startMainScreenBgm() async {
    _audio.clearBgm();
    _audio.addToBgm('main_theme.mp3');
    _audio.playBgm();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _startMainScreenBgm();
      GoRouter.of(context).routerDelegate.addListener(() async {
        final location =
            GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
        print(location);
        switch (location) {
          case '/main/pullUpGame':
            _audio.stopBgm();
            _startPullUpGameBgm();
            break;
          case '/':
            await _audio.stopBgm();
            _startMainScreenBgm();
            break;
          default:
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
