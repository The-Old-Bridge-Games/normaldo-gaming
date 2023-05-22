import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
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
