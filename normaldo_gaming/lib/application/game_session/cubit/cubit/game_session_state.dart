part of 'game_session_cubit.dart';

@freezed
class GameSessionState with _$GameSessionState {
  const factory GameSessionState({
    required int score,
    required bool isDead,
    @Assert('lives >= 0') required int lives,
    required int dollars,
    required bool paused,
    required bool hit,
    @Assert('level >= 0') required int level,
  }) = _GameSessionState;

  factory GameSessionState.initial() => const GameSessionState(
        score: 0,
        isDead: false,
        lives: 1,
        dollars: 0,
        paused: false,
        hit: false,
        level: 0,
      );
}
