import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/create_user/create_user_screen.dart';
import 'package:normaldo_gaming/ui/main_screen/main_screen.dart';
import 'package:normaldo_gaming/ui/pull_up_game/pull_up_game_widget.dart';
import 'package:normaldo_gaming/ui/root/root_screen.dart';

part 'utils/go_route_ext.dart';
part 'utils/ng_routes.dart';

abstract class NGRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: NGRoutes.root.path,
        builder: (context, state) => const RootScreen(),
      ),
      GoRoute(
        path: NGRoutes.main.path,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: NGRoutes.createUser.path,
        builder: (context, state) => const CreateUserScreen(),
      ),
      GoRoute(
        path: NGRoutes.pullUpGame.path,
        builder: (context, state) => BlocProvider<GameSessionCubit>(
          create: (context) => injector.get(),
          child: const PullUpGameWidget(),
        ),
      ),
    ],
  );
}
