import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';

final injector = Injector();

void initializeInjector() {
  injector.map<UserCubit>((injector) => UserCubit());
}
