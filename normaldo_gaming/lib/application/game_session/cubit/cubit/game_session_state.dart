part of 'game_session_cubit.dart';

@freezed
class GameSessionState with _$GameSessionState {
  const factory GameSessionState({
    required int score,
    required bool isDead,
    required int dollars,
    required bool paused,
    required bool hit,
  }) = _GameSessionState;

  factory GameSessionState.initial() => const GameSessionState(
        score: 0,
        isDead: false,
        dollars: 0,
        paused: false,
        hit: false,
      );
}
