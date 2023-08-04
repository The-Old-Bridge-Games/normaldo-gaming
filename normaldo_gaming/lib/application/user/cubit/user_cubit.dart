import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:normaldo_gaming/data/user/models/user_model.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';
import 'package:normaldo_gaming/injection/injection.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserState.initial());

  final _levelManager = injector.get<LevelManager>();

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

  void takeDollars(int dollars) {
    assert(dollars < state.user.dollars);
    emit(
      state.copyWith(
        user: UserModel.fromEntity(state.user)
            .copyWith(dollars: state.user.dollars - dollars)
            .toEntity(),
      ),
    );
  }

  void addExtraLife(int amount) {
    assert(amount > 0);
    emit(
      state.copyWith(
        user: UserModel.fromEntity(state.user)
            .copyWith(extraLives: state.user.extraLives + amount)
            .toEntity(),
      ),
    );
  }

  void takeExtraLife(int amount) {
    assert(amount > 0);
    emit(
      state.copyWith(
        user: UserModel.fromEntity(state.user)
            .copyWith(dollars: state.user.extraLives - amount)
            .toEntity(),
      ),
    );
  }

  void changeName(String name) {
    assert(name.length >= 3, "too short name");
    emit(state.copyWith(
      user: UserModel.fromEntity(state.user).copyWith(name: name).toEntity(),
    ));
  }

  void addExp(int exp) {
    assert(exp > 0);
    var newExp = state.user.exp + exp;
    var newLevel = state.user.level;
    void configureLevel() {
      if (newExp >= _levelManager.nextLevelExp(state.user)) {
        final levelsCount = newExp ~/ _levelManager.nextLevelExp(state.user);
        newExp = newExp % _levelManager.nextLevelExp(state.user);
        if (levelsCount > 0 || newExp == 0) {
          newLevel += levelsCount;
          configureLevel();
        } else {
          return;
        }
      }
    }

    configureLevel();

    emit(state.copyWith(
      user: UserModel.fromEntity(state.user)
          .copyWith(
            exp: newExp,
            level: newLevel,
          )
          .toEntity(),
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
      level: state.user.level,
      exp: state.user.exp,
      extraLives: state.user.extraLives,
    ).toJson();
  }
}
