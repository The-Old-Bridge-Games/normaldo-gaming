import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/main_screen/main_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  void _blocListener(BuildContext context, UserState state) {
    if (state.name.isEmpty) {
      context.goRoute(NGRoutes.createUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: _blocListener,
      child: const MainScreen(),
    );
  }
}
