import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:normaldo_gaming/application/missions/missions_cubit.dart';

part 'game_session_state.dart';
part 'game_session_cubit.freezed.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  static const hitRevival = Duration(seconds: 2);

  GameSessionCubit(this.missionsCubit) : super(GameSessionState.initial());

  final MissionsCubit missionsCubit;

  void eatPizza() {
    emit(state.copyWith(
      score: state.score + 1,
    ));
    missionsCubit.checkState(state: state);
  }

  void changeLevel(int level) {
    emit(state.copyWith(level: level));
    missionsCubit.checkState(state: state);
  }

  Future<void> takeHit() async {
    if (state.hit || state.isDead) return;
    emit(state.copyWith(hit: true));
    await Future.delayed(hitRevival);
    emit(state.copyWith(hit: false));
  }

  Future<void> revive({bool withAd = false}) async {
    if (withAd) {
      emit(state.copyWith(
        isDead: false,
        revived: false,
        revivedWithAd: true,
        hit: true,
      ));
    } else {
      emit(state.copyWith(
        isDead: false,
        revived: true,
        hit: true,
      ));
    }
  }

  void resetHit() {
    emit(state.copyWith(hit: false));
  }

  void addDollars(int amount) {
    assert(amount > 0);
    emit(state.copyWith(dollars: state.dollars + amount));
  }

  void togglePause() {
    emit(state.copyWith(paused: !state.paused));
  }

  void die() {
    emit(state.copyWith(isDead: true));
    missionsCubit.checkState(state: state);
  }
}
