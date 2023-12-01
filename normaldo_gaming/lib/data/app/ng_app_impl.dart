import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:home_indicator/home_indicator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/application/sign_in/sign_in_cubit.dart';
import 'package:normaldo_gaming/application/sign_up/sign_up_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/config/config.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/domain/app/ng_app.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/widgets/config_inherited_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class NGAppImpl implements NGApp {
  @override
  Future<void> run() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await EasyLocalization.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: binding);
    FlameAudio.bgm.initialize();
    final config = kDebugMode ? Config.dev() : Config.prod();
    UnityAds.init(
      gameId: Platform.isIOS ? config.iosAdId : config.androidAdId,
      testMode: kDebugMode,
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
    await FlameAudio.audioCache.loadAll([
      'main_theme.mp3',
      'club_track.mp3',
      'hard_track.mp3',
      'rolling.mp3',
      'sfx/beer1.mp3',
      'sfx/bomb1.mp3',
      'sfx/button1.mp3',
      'sfx/byaaaa.mp3',
      'sfx/casey.mp3',
      'sfx/dollars.mp3',
      'sfx/drink.mp3',
      'sfx/drink2.mp3',
      'sfx/eeeeee.mp3',
      'sfx/game_over.mp3',
      'sfx/game_over2.mp3',
      'sfx/gantelya1.mp3',
      'sfx/havaet.mp3',
      'sfx/havaet2.mp3',
      'sfx/herb_rasta.mp3',
      'sfx/magic_sound_longer.mp3',
      'sfx/magic_sound.mp3',
      'sfx/molotov1.mp3',
      'sfx/round_box.mp3',
      'sfx/sound_death.mp3',
      'sfx/subbwoofer.mp3',
      'sfx/super_pizza.mp3',
      'sfx/ydar.mp3',
      'sfx/yyyyyyy.mp3',
      'sfx/mission_notification.mp3',
      'sfx/spin.mp3',
      'sfx/roll_dropped.mp3',
    ]);
    await AudioPlayer.global.setAudioContext(AudioContextConfig(
      respectSilence: true,
      duckAudio: true,
    ).build());

    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    HomeIndicator.deferScreenEdges(ScreenEdge.values);

    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());

    initializeInjector(config);
    await injector.get<NgAudio>().init();
    await injector.get<LevelManager>().init();
    const supportedLocales = [Locale('ru'), Locale('en')];
    runApp(EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => injector.get()..auth()),
          BlocProvider<UserCubit>(create: (context) => injector.get()),
          BlocProvider<SignUpCubit>(create: (context) => injector.get()),
          BlocProvider<SignInCubit>(create: (context) => injector.get()),
        ],
        child: ConfigInheritedWidget(
          config: config,
          child: const _AppWidget(),
        ),
      ),
    ));
  }
}

class _AppWidget extends StatelessWidget {
  const _AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: NGRouter.router,
      debugShowCheckedModeBanner: false,
      theme: _theme,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}

final _theme = ThemeData(
    fontFamily: "NormaldoFont",
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
      shadowColor: MaterialStatePropertyAll(Colors.transparent),
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
    )),
    textTheme: const TextTheme(
      displayLarge: NGTheme.displayLarge,
      displayMedium: NGTheme.displayMedium,
      displaySmall: NGTheme.displaySmall,
      bodySmall: NGTheme.bodySmall,
      labelSmall: NGTheme.labelSmall,
    ));
