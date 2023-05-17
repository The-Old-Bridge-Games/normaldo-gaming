import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/ui/main_screen.dart';

abstract class NGRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}
