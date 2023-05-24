part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    required int score,
    required String name,
    required int dollars,
  }) = _UserState;

  factory UserState.initial() => const UserState(
        score: 0,
        name: '',
        dollars: 0,
      );
}
