import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/audio/ng_audio_widget.dart';
import 'package:normaldo_gaming/ui/create_user/create_user_screen.dart';
import 'package:normaldo_gaming/ui/main_screen/main_screen.dart';
import 'package:normaldo_gaming/ui/pull_up_game/pull_up_game_widget.dart';
import 'package:normaldo_gaming/ui/root/root_screen.dart';

part 'utils/go_route_ext.dart';
part 'utils/ng_routes.dart';

abstract class NGRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    observers: [AudioObserver()],
    routes: [
      GoRoute(
          path: NGRoutes.root.path,
          builder: (context, state) => const RootScreen(),
          routes: [
            GoRoute(
                path: NGRoutes.main.name,
                builder: (context, state) =>
                    const BlocListener<UserCubit, UserState>(
                      listener: _userBlocListener,
                      child: MainScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: NGRoutes.pullUpGame.name,
                    builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider<GameSessionCubit>(
                            create: (context) => injector.get()),
                        BlocProvider<LevelBloc>(
                            create: (context) => injector.get()),
                      ],
                      child: const PullUpGameWidget(),
                    ),
                  ),
                ]),
            GoRoute(
              path: NGRoutes.createUser.name,
              builder: (context, state) => const CreateUserScreen(),
            ),
          ]),
    ],
  );

  static void _userBlocListener(BuildContext context, UserState state) {
    if (state.user.name.isEmpty) {
      context.goRoute(NGRoutes.createUser);
    }
  }
}
