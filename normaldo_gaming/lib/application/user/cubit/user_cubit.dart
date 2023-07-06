import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:normaldo_gaming/data/user/models/user_model.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserState.initial());

  void changeHighScore(int highScore) {
    assert(highScore > 0, "high score must be greater than 0");
    emit(state.copyWith(
      user: UserModel.fromEntity(state.user)
          .copyWith(highScore: highScore)
          .toEntity(),
    ));
  }

  void addDollars(int dollars) {
    assert(dollars >= 0, "dollars amount must be greater than 0");
    emit(state.copyWith(
      user: UserModel.fromEntity(state.user)
          .copyWith(dollars: state.user.dollars + dollars)
          .toEntity(),
    ));
  }

  void changeName(String name) {
    assert(name.length >= 3, "too short name");
    emit(state.copyWith(
      user: UserModel.fromEntity(state.user).copyWith(name: name).toEntity(),
    ));
  }

  void reset() {
    emit(UserState.initial());
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState(
      user: UserModel.fromJson(json).toEntity(),
    );
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    final user = state.user;
    return UserModel(
      id: user.id,
      name: user.name,
      dollars: user.dollars,
      highScore: user.highScore,
    ).toJson();
  }
}
