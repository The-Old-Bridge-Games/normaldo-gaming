import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/application/auth/auth_cubit.dart';
import 'package:normaldo_gaming/routing/ng_router.dart';
import 'package:normaldo_gaming/ui/audio/ng_audio_widget.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NgAudioWidget(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print(state);
          state.when(
            initial: () {},
            authorized: () => context.push(NGRoutes.main.path),
            notAuthorized: () => context.push(NGRoutes.signUp.path),
          );
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
