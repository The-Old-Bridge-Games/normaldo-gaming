import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/injection/injection.dart';

part 'game_session_state.dart';
part 'game_session_cubit.freezed.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  static const hitRevival = Duration(seconds: 2);

  /// 3 extra lives by pizza packs and 1 initial life
  static const maxLivesCount = 4;

  GameSessionCubit() : super(GameSessionState.initial());

  void eatPizza() {
    emit(state.copyWith(
      score: state.score + 1,
    ));
  }

  Future<void> takeHit() async {
    if (state.hit || state.isDead) return;
    emit(state.copyWith(hit: true));
    await Future.delayed(hitRevival);
    emit(state.copyWith(hit: false));
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
    if (!state.paused) {
      injector.get<NgAudio>().resumeBgm();
    } else {
      injector.get<NgAudio>().pauseBgm();
    }
  }

  void die() {
    emit(state.copyWith(isDead: true));
  }
}
