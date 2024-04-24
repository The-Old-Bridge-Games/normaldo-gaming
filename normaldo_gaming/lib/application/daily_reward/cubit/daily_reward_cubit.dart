import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/roller/roller.dart';
import 'package:ntp/ntp.dart';

part 'daily_reward_state.dart';
part 'daily_reward_cubit.freezed.dart';

class DailyRewardCubit extends Cubit<DailyRewardState> {
  DailyRewardCubit() : super(DailyRewardState.initial()) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.delay > Duration.zero) {
        emit(state.copyWith(delay: state.delay - const Duration(seconds: 1)));
      }
    });
  }

  final _roller = Roller<String>([
    ('dollars50', 60),
    ('dollars100', 10),
    ('dollars150', 5),
    ('heart', 20),
  ]);

  Future<void> applyAward(UserCubit userCubit) async {
    if (state.canApply) {
      final reward = _roller.roll();
      switch (reward) {
        case 'dollars50':
          userCubit.addDollars(50);
        case 'dollars100':
          userCubit.addDollars(100);
        case 'dollars150':
          userCubit.addDollars(150);
      }
      final currTime = await NTP.now();
      emit(state.copyWith(
          delay: const Duration(hours: 24) -
              Duration(
                hours: currTime.hour,
                minutes: currTime.minute,
                seconds: currTime.second,
              )));
    }
  }
}
