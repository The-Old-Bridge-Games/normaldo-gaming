import 'package:flutter/material.dart';
import 'package:normaldo_gaming/domain/app/ng_app.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/main_screen.dart';

class NGAppImpl implements NGApp {
  @override
  Future<void> run() async {
    initializeInjector();
    runApp(const MainScreen());
  }
}
