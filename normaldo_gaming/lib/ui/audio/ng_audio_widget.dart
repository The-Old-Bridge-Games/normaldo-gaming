import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class AudioObserver extends NavigatorObserver {
  final audio = injector.get<NgAudio>();

  @override
  void didPop(Route route, Route? previousRoute) {
    final previousName = previousRoute?.settings.name;
    final name = route.settings.name ?? '';
    print('[POP] PREVIOUS ROUTE NAME: $previousName');
    print('[POP] ROUTE NAME: $name');
    check(
      name,
      previousName,
    );
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final name = route.settings.name ?? '';
    print('[PUSH] ROUTE NAME: $name');
    check(name);
    super.didPush(route, previousRoute);
  }

  Future<void> _startPullUpGameBgm() async {
    await audio.stopBgm();
    audio.clearBgm();
    audio.addAllToBgm(['mix.mp3']);
    audio.playBgm();
  }

  Future<void> _startMainScreenBgm() async {
    await audio.stopBgm();
    audio.clearBgm();
    audio.addToBgm('main_theme.mp3');
    audio.playBgm();
  }

  Future<void> check(String location, [String? previousLocation]) async {
    final audio = injector.get<NgAudio>();
    switch (location) {
      case 'pullUpGame':
        if (previousLocation == 'main') {
          await audio.stopBgm();
          _startMainScreenBgm();
          break;
        }
        audio.stopBgm();
        _startPullUpGameBgm();
        break;
      case 'main':
        await audio.stopBgm();
        _startMainScreenBgm();
        break;
      default:
        break;
    }
  }
}

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
    return GoRouterState.of(context).matchedLocation;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
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
