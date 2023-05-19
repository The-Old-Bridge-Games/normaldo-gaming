import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session_state.dart';
part 'game_session_cubit.freezed.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit() : super(GameSessionState.initial());

  static const initialLivesCount = 5;

  void eatPizza() {
    emit(state.copyWith(score: state.score + 1));
  }

  void takeLife() {
    final newLives = state.lives - 1;
    emit(state.copyWith(lives: newLives));
    if (newLives == 0) {
      die();
    }
  }

  void addDollars(int amount) {
    assert(amount > 0);
    emit(state.copyWith(dollars: state.dollars + 1));
  }

  void die() {
    emit(state.copyWith(
      isDead: true,
      // TODO: – Remove later
      lives: initialLivesCount,
    ));
  }
}
