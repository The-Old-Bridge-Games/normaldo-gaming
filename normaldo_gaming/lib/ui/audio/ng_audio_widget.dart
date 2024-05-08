import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:phone_state/phone_state.dart';

class AudioObserver extends NavigatorObserver with HasNgAudio {
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
    return audio.playAssetBgm('audio/mix.mp3');
  }

  Future<void> _startMainScreenBgm() async {
    await audio.stopBgm();
    return audio.playBgm();
  }

  Future<void> check(String location, [String? previousLocation]) async {
    switch (location) {
      case 'pullUpGame':
        if (previousLocation == 'root') {
          _startMainScreenBgm();
          break;
        }
        audio.stopBgm();
        _startPullUpGameBgm();
        break;
      case 'main':
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
    with WidgetsBindingObserver, HasNgAudio {
  StreamSubscription? _incomingCallSubscription;

  String get location {
    if (!mounted) return '';
    return GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        audio.pauseBgm();
        break;
      case AppLifecycleState.resumed:
        if (location != '/main/pullUpGame') {
          audio.resumeBgm();
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _incomingCallSubscription = PhoneState.stream.listen((state) {
      if (state.status == PhoneStateStatus.CALL_ENDED) {
        audio.resumeBgm();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _incomingCallSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
