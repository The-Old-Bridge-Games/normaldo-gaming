// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameSessionState {
  int get score => throw _privateConstructorUsedError;
  bool get isDead => throw _privateConstructorUsedError;
  int get lives => throw _privateConstructorUsedError;
  int get dollars => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameSessionStateCopyWith<GameSessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSessionStateCopyWith<$Res> {
  factory $GameSessionStateCopyWith(
          GameSessionState value, $Res Function(GameSessionState) then) =
      _$GameSessionStateCopyWithImpl<$Res, GameSessionState>;
  @useResult
  $Res call({int score, bool isDead, int lives, int dollars});
}

/// @nodoc
class _$GameSessionStateCopyWithImpl<$Res, $Val extends GameSessionState>
    implements $GameSessionStateCopyWith<$Res> {
  _$GameSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? isDead = null,
    Object? lives = null,
    Object? dollars = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      isDead: null == isDead
          ? _value.isDead
          : isDead // ignore: cast_nullable_to_non_nullable
              as bool,
      lives: null == lives
          ? _value.lives
          : lives // ignore: cast_nullable_to_non_nullable
              as int,
      dollars: null == dollars
          ? _value.dollars
          : dollars // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameSessionStateCopyWith<$Res>
    implements $GameSessionStateCopyWith<$Res> {
  factory _$$_GameSessionStateCopyWith(
          _$_GameSessionState value, $Res Function(_$_GameSessionState) then) =
      __$$_GameSessionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int score, bool isDead, int lives, int dollars});
}

/// @nodoc
class __$$_GameSessionStateCopyWithImpl<$Res>
    extends _$GameSessionStateCopyWithImpl<$Res, _$_GameSessionState>
    implements _$$_GameSessionStateCopyWith<$Res> {
  __$$_GameSessionStateCopyWithImpl(
      _$_GameSessionState _value, $Res Function(_$_GameSessionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? isDead = null,
    Object? lives = null,
    Object? dollars = null,
  }) {
    return _then(_$_GameSessionState(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      isDead: null == isDead
          ? _value.isDead
          : isDead // ignore: cast_nullable_to_non_nullable
              as bool,
      lives: null == lives
          ? _value.lives
          : lives // ignore: cast_nullable_to_non_nullable
              as int,
      dollars: null == dollars
          ? _value.dollars
          : dollars // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GameSessionState implements _GameSessionState {
  const _$_GameSessionState(
      {required this.score,
      required this.isDead,
      required this.lives,
      required this.dollars});

  @override
  final int score;
  @override
  final bool isDead;
  @override
  final int lives;
  @override
  final int dollars;

  @override
  String toString() {
    return 'GameSessionState(score: $score, isDead: $isDead, lives: $lives, dollars: $dollars)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameSessionState &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isDead, isDead) || other.isDead == isDead) &&
            (identical(other.lives, lives) || other.lives == lives) &&
            (identical(other.dollars, dollars) || other.dollars == dollars));
  }

  @override
  int get hashCode => Object.hash(runtimeType, score, isDead, lives, dollars);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameSessionStateCopyWith<_$_GameSessionState> get copyWith =>
      __$$_GameSessionStateCopyWithImpl<_$_GameSessionState>(this, _$identity);
}

abstract class _GameSessionState implements GameSessionState {
  const factory _GameSessionState(
      {required final int score,
      required final bool isDead,
      required final int lives,
      required final int dollars}) = _$_GameSessionState;

  @override
  int get score;
  @override
  bool get isDead;
  @override
  int get lives;
  @override
  int get dollars;
  @override
  @JsonKey(ignore: true)
  _$$_GameSessionStateCopyWith<_$_GameSessionState> get copyWith =>
      throw _privateConstructorUsedError;
}
