import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_death_state.dart';
part 'pre_death_cubit.freezed.dart';

class PreDeathCubit extends Cubit<PreDeathState> {
  PreDeathCubit() : super(PreDeathState.initial()) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.adState == Showing() ||
          state.adState == Loading() ||
          state.adState == Finished()) return;
      if (state.skipValue <= 0) {
        timer.cancel();
        emit(state.copyWith(skipValue: 0, skipped: true));
      } else if (state.adState != Loading()) {
        emit(state.copyWith(skipValue: state.skipValue - 0.2));
      }
    });
  }

  void skip() {
    emit(state.copyWith(skipped: true));
  }

  void setAdState(AdState adState) {
    emit(state.copyWith(adState: adState));
  }
}
