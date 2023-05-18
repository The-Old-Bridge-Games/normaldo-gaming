import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserState.initial());

  void changeHighScore(int highScore) {
    assert(highScore > 0, "high score must be greater than 0");
    emit(state.copyWith(
      score: highScore,
    ));
  }

  void changeName(String name) {
    assert(name.length >= 3, "too short name");
    emit(state.copyWith(name: name));
  }

  void reset() {
    emit(UserState.initial());
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState(
      score: json['score'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      'score': state.score,
      'name': state.name,
    };
  }
}
