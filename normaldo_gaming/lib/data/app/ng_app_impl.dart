import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/app/ng_app.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:path_provider/path_provider.dart';

class NGAppImpl implements NGApp {
  @override
  Future<void> run() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: binding);
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'main_theme.mp3',
      'club_track.mp3',
      'hard_track.mp3',
      'sfx/BEER.mp3',
      'sfx/bla.mp3',
      'sfx/BOMB.mp3',
      'sfx/BOX.mp3',
      'sfx/BUTTON.mp3',
      'sfx/casey.mp3',
      'sfx/eaat.mp3',
      'sfx/eat_pizza.mp3',
      'sfx/EAT_SUPER_PIZZA.mp3',
      'sfx/FATTNESS.mp3',
      'sfx/GAMEOVER.mp3',
      'sfx/GANTELYA.mp3',
      'sfx/HURRY_UP.mp3',
      'sfx/MOLOTOV.mp3',
      'sfx/pizza_new_target.mp3',
      'sfx/SUB.mp3',
    ]);
    await AudioPlayer.global.setAudioContext(AudioContextConfig(
      forceSpeaker: false,
      duckAudio: true,
    ).build());
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());

    initializeInjector();
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => injector.get()),
      ],
      child: MaterialApp.router(
        routerConfig: NGRouter.router,
        debugShowCheckedModeBanner: false,
        theme: _theme,
      ),
    ));
  }
}

final _theme = ThemeData(
    fontFamily: "HyperStiffRoundBootiedOpossumRegular",
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
    ));
