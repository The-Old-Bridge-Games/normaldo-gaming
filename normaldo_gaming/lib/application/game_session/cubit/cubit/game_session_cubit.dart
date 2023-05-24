import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session_state.dart';
part 'game_session_cubit.freezed.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  static const hitRevival = Duration(seconds: 3);
  static const initialLivesCount = 5;

  GameSessionCubit() : super(GameSessionState.initial());

  void eatPizza() {
    emit(state.copyWith(score: state.score + 1));
  }

  void decreaseHunger() {
    final newLives = state.lives - 1;
    emit(state.copyWith(lives: newLives));
    if (newLives == 0) {
      die();
    }
  }

  void takeHit() async {
    if (state.hit) return;
    final newLives = state.lives - 1;
    emit(state.copyWith(lives: newLives, hit: true));
    if (newLives == 0) {
      die();
    }
    Future.delayed(hitRevival)
        .whenComplete(() => emit(state.copyWith(hit: false)));
  }

  void resetHit() {
    emit(state.copyWith(hit: false));
  }

  void addDollars(int amount) {
    assert(amount > 0);
    emit(state.copyWith(dollars: state.dollars + 1));
  }

  void togglePause() {
    emit(state.copyWith(paused: !state.paused));
  }

  void die() {
    emit(state.copyWith(
      isDead: true,
      // TODO: – Remove later
      lives: initialLivesCount,
    ));
  }
}
