import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/ads/ads_cubit.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/application/shop_items_list/shop_items_list_cubit.dart';
import 'package:normaldo_gaming/application/slot_machine/cubit/slot_machine_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/audio/ng_audio_widget.dart';
import 'package:normaldo_gaming/ui/create_user/create_user_screen.dart';
import 'package:normaldo_gaming/ui/main_screen/main_screen.dart';
import 'package:normaldo_gaming/ui/main_screen/missions_screen.dart';
import 'package:normaldo_gaming/ui/main_screen/widgets/new_level_dialog.dart';
import 'package:normaldo_gaming/ui/pull_up_game/pull_up_game_widget.dart';
import 'package:normaldo_gaming/ui/root/root_screen.dart';
import 'package:normaldo_gaming/ui/settings/settings_screen.dart';
import 'package:normaldo_gaming/ui/shop/shop_screen.dart';
import 'package:normaldo_gaming/ui/slot_machine/slot_machine_screen.dart';

part 'utils/go_route_ext.dart';
part 'utils/ng_routes.dart';

abstract class NGRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    observers: [AudioObserver()],
    routes: [
      GoRoute(
          path: NGRoutes.root.path,
          name: NGRoutes.root.name,
          builder: (context, state) => const RootScreen(),
          routes: [
            GoRoute(
                path: NGRoutes.main.name,
                name: NGRoutes.main.name,
                builder: (context, state) => BlocListener<UserCubit, UserState>(
                      listener: _userBlocListener,
                      child: BlocListener<UserCubit, UserState>(
                        listenWhen: (previous, current) =>
                            previous.user.level < current.user.level,
                        listener: _newLevelListener,
                        child: const MainScreen(),
                      ),
                    ),
                routes: [
                  GoRoute(
                    path: NGRoutes.pullUpGame.name,
                    name: NGRoutes.pullUpGame.name,
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
                  GoRoute(
                    path: NGRoutes.missions.name,
                    name: NGRoutes.missions.name,
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: MissionsScreen(
                        tag: state.uri.queryParameters['tag'] as String,
                      ),
                      transitionDuration: const Duration(milliseconds: 300),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 300),
                      opaque: false,
                      barrierColor: Colors.transparent,
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
                        const end = Offset.zero;
                        final tween = Tween(begin: begin, end: end);
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  ),
                  GoRoute(
                    path: NGRoutes.settings.name,
                    name: NGRoutes.settings.name,
                    builder: (context, state) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: NGRoutes.slots.name,
                    name: NGRoutes.slots.name,
                    builder: (context, state) => BlocProvider<SlotMachineCubit>(
                        create: (context) => injector.get(),
                        child: const SlotMachineScreen()),
                  ),
                  GoRoute(
                    path: NGRoutes.shop.name,
                    name: NGRoutes.shop.name,
                    builder: (context, state) => MultiBlocProvider(providers: [
                      BlocProvider<ShopItemsListCubit>(
                          create: (context) => injector.get()..loadList()),
                      BlocProvider<AdsCubit>(
                          create: (context) => injector.get()),
                    ], child: const ShopScreen()),
                  ),
                ]),
            GoRoute(
              path: NGRoutes.createUser.name,
              name: NGRoutes.createUser.name,
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

  static void _newLevelListener(BuildContext context, UserState state) async {
    await Future.delayed(const Duration(milliseconds: 500));
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => NewLevelDialog(
              reward: state.user.level * 10,
              level: state.user.level,
            )).then((value) async {
      context.read<UserCubit>().addDollars(state.user.level * 10);
    });
  }
}
