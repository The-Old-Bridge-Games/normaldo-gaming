// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LevelEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelEventCopyWith<$Res> {
  factory $LevelEventCopyWith(
          LevelEvent value, $Res Function(LevelEvent) then) =
      _$LevelEventCopyWithImpl<$Res, LevelEvent>;
}

/// @nodoc
class _$LevelEventCopyWithImpl<$Res, $Val extends LevelEvent>
    implements $LevelEventCopyWith<$Res> {
  _$LevelEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ChangeLevelCopyWith<$Res> {
  factory _$$_ChangeLevelCopyWith(
          _$_ChangeLevel value, $Res Function(_$_ChangeLevel) then) =
      __$$_ChangeLevelCopyWithImpl<$Res>;
  @useResult
  $Res call({int level, List<Items> effects});
}

/// @nodoc
class __$$_ChangeLevelCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_ChangeLevel>
    implements _$$_ChangeLevelCopyWith<$Res> {
  __$$_ChangeLevelCopyWithImpl(
      _$_ChangeLevel _value, $Res Function(_$_ChangeLevel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? effects = null,
  }) {
    return _then(_$_ChangeLevel(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      effects: null == effects
          ? _value._effects
          : effects // ignore: cast_nullable_to_non_nullable
              as List<Items>,
    ));
  }
}

/// @nodoc

class _$_ChangeLevel implements _ChangeLevel {
  const _$_ChangeLevel(
      {required this.level, required final List<Items> effects})
      : _effects = effects;

  @override
  final int level;
  final List<Items> _effects;
  @override
  List<Items> get effects {
    if (_effects is EqualUnmodifiableListView) return _effects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_effects);
  }

  @override
  String toString() {
    return 'LevelEvent.changeLevel(level: $level, effects: $effects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeLevel &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._effects, _effects));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, level, const DeepCollectionEquality().hash(_effects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeLevelCopyWith<_$_ChangeLevel> get copyWith =>
      __$$_ChangeLevelCopyWithImpl<_$_ChangeLevel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return changeLevel(level, effects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return changeLevel?.call(level, effects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (changeLevel != null) {
      return changeLevel(level, effects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return changeLevel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return changeLevel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (changeLevel != null) {
      return changeLevel(this);
    }
    return orElse();
  }
}

abstract class _ChangeLevel implements LevelEvent {
  const factory _ChangeLevel(
      {required final int level,
      required final List<Items> effects}) = _$_ChangeLevel;

  int get level;
  List<Items> get effects;
  @JsonKey(ignore: true)
  _$$_ChangeLevelCopyWith<_$_ChangeLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_StartFigureCopyWith<$Res> {
  factory _$$_StartFigureCopyWith(
          _$_StartFigure value, $Res Function(_$_StartFigure) then) =
      __$$_StartFigureCopyWithImpl<$Res>;
  @useResult
  $Res call({FigureEvent figure});

  $FigureEventCopyWith<$Res> get figure;
}

/// @nodoc
class __$$_StartFigureCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_StartFigure>
    implements _$$_StartFigureCopyWith<$Res> {
  __$$_StartFigureCopyWithImpl(
      _$_StartFigure _value, $Res Function(_$_StartFigure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? figure = null,
  }) {
    return _then(_$_StartFigure(
      figure: null == figure
          ? _value.figure
          : figure // ignore: cast_nullable_to_non_nullable
              as FigureEvent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FigureEventCopyWith<$Res> get figure {
    return $FigureEventCopyWith<$Res>(_value.figure, (value) {
      return _then(_value.copyWith(figure: value));
    });
  }
}

/// @nodoc

class _$_StartFigure implements _StartFigure {
  const _$_StartFigure({required this.figure});

  @override
  final FigureEvent figure;

  @override
  String toString() {
    return 'LevelEvent.startFigure(figure: $figure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StartFigure &&
            (identical(other.figure, figure) || other.figure == figure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, figure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StartFigureCopyWith<_$_StartFigure> get copyWith =>
      __$$_StartFigureCopyWithImpl<_$_StartFigure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return startFigure(figure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return startFigure?.call(figure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (startFigure != null) {
      return startFigure(figure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return startFigure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return startFigure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (startFigure != null) {
      return startFigure(this);
    }
    return orElse();
  }
}

abstract class _StartFigure implements LevelEvent {
  const factory _StartFigure({required final FigureEvent figure}) =
      _$_StartFigure;

  FigureEvent get figure;
  @JsonKey(ignore: true)
  _$$_StartFigureCopyWith<_$_StartFigure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_StartMiniGameCopyWith<$Res> {
  factory _$$_StartMiniGameCopyWith(
          _$_StartMiniGame value, $Res Function(_$_StartMiniGame) then) =
      __$$_StartMiniGameCopyWithImpl<$Res>;
  @useResult
  $Res call({MiniGame game});

  $MiniGameCopyWith<$Res> get game;
}

/// @nodoc
class __$$_StartMiniGameCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_StartMiniGame>
    implements _$$_StartMiniGameCopyWith<$Res> {
  __$$_StartMiniGameCopyWithImpl(
      _$_StartMiniGame _value, $Res Function(_$_StartMiniGame) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
  }) {
    return _then(_$_StartMiniGame(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as MiniGame,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MiniGameCopyWith<$Res> get game {
    return $MiniGameCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value));
    });
  }
}

/// @nodoc

class _$_StartMiniGame implements _StartMiniGame {
  const _$_StartMiniGame({required this.game});

  @override
  final MiniGame game;

  @override
  String toString() {
    return 'LevelEvent.startMiniGame(game: $game)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StartMiniGame &&
            (identical(other.game, game) || other.game == game));
  }

  @override
  int get hashCode => Object.hash(runtimeType, game);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StartMiniGameCopyWith<_$_StartMiniGame> get copyWith =>
      __$$_StartMiniGameCopyWithImpl<_$_StartMiniGame>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return startMiniGame(game);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return startMiniGame?.call(game);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (startMiniGame != null) {
      return startMiniGame(game);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return startMiniGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return startMiniGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (startMiniGame != null) {
      return startMiniGame(this);
    }
    return orElse();
  }
}

abstract class _StartMiniGame implements LevelEvent {
  const factory _StartMiniGame({required final MiniGame game}) =
      _$_StartMiniGame;

  MiniGame get game;
  @JsonKey(ignore: true)
  _$$_StartMiniGameCopyWith<_$_StartMiniGame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FinishMiniGameCopyWith<$Res> {
  factory _$$_FinishMiniGameCopyWith(
          _$_FinishMiniGame value, $Res Function(_$_FinishMiniGame) then) =
      __$$_FinishMiniGameCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FinishMiniGameCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_FinishMiniGame>
    implements _$$_FinishMiniGameCopyWith<$Res> {
  __$$_FinishMiniGameCopyWithImpl(
      _$_FinishMiniGame _value, $Res Function(_$_FinishMiniGame) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_FinishMiniGame implements _FinishMiniGame {
  const _$_FinishMiniGame();

  @override
  String toString() {
    return 'LevelEvent.finishMiniGame()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_FinishMiniGame);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return finishMiniGame();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return finishMiniGame?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (finishMiniGame != null) {
      return finishMiniGame();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return finishMiniGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return finishMiniGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (finishMiniGame != null) {
      return finishMiniGame(this);
    }
    return orElse();
  }
}

abstract class _FinishMiniGame implements LevelEvent {
  const factory _FinishMiniGame() = _$_FinishMiniGame;
}

/// @nodoc
abstract class _$$_StartRandomFigureCopyWith<$Res> {
  factory _$$_StartRandomFigureCopyWith(_$_StartRandomFigure value,
          $Res Function(_$_StartRandomFigure) then) =
      __$$_StartRandomFigureCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FigureEvent>? figures});
}

/// @nodoc
class __$$_StartRandomFigureCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_StartRandomFigure>
    implements _$$_StartRandomFigureCopyWith<$Res> {
  __$$_StartRandomFigureCopyWithImpl(
      _$_StartRandomFigure _value, $Res Function(_$_StartRandomFigure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? figures = freezed,
  }) {
    return _then(_$_StartRandomFigure(
      figures: freezed == figures
          ? _value._figures
          : figures // ignore: cast_nullable_to_non_nullable
              as List<FigureEvent>?,
    ));
  }
}

/// @nodoc

class _$_StartRandomFigure implements _StartRandomFigure {
  const _$_StartRandomFigure({final List<FigureEvent>? figures})
      : _figures = figures;

  final List<FigureEvent>? _figures;
  @override
  List<FigureEvent>? get figures {
    final value = _figures;
    if (value == null) return null;
    if (_figures is EqualUnmodifiableListView) return _figures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LevelEvent.startRandomFigure(figures: $figures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StartRandomFigure &&
            const DeepCollectionEquality().equals(other._figures, _figures));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_figures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StartRandomFigureCopyWith<_$_StartRandomFigure> get copyWith =>
      __$$_StartRandomFigureCopyWithImpl<_$_StartRandomFigure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return startRandomFigure(figures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return startRandomFigure?.call(figures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (startRandomFigure != null) {
      return startRandomFigure(figures);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return startRandomFigure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return startRandomFigure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (startRandomFigure != null) {
      return startRandomFigure(this);
    }
    return orElse();
  }
}

abstract class _StartRandomFigure implements LevelEvent {
  const factory _StartRandomFigure({final List<FigureEvent>? figures}) =
      _$_StartRandomFigure;

  List<FigureEvent>? get figures;
  @JsonKey(ignore: true)
  _$$_StartRandomFigureCopyWith<_$_StartRandomFigure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ChangeSpeedCopyWith<$Res> {
  factory _$$_ChangeSpeedCopyWith(
          _$_ChangeSpeed value, $Res Function(_$_ChangeSpeed) then) =
      __$$_ChangeSpeedCopyWithImpl<$Res>;
  @useResult
  $Res call({double speed, List<Items> effects});
}

/// @nodoc
class __$$_ChangeSpeedCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_ChangeSpeed>
    implements _$$_ChangeSpeedCopyWith<$Res> {
  __$$_ChangeSpeedCopyWithImpl(
      _$_ChangeSpeed _value, $Res Function(_$_ChangeSpeed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? effects = null,
  }) {
    return _then(_$_ChangeSpeed(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      effects: null == effects
          ? _value._effects
          : effects // ignore: cast_nullable_to_non_nullable
              as List<Items>,
    ));
  }
}

/// @nodoc

class _$_ChangeSpeed implements _ChangeSpeed {
  const _$_ChangeSpeed(
      {required this.speed, required final List<Items> effects})
      : _effects = effects;

  @override
  final double speed;
  final List<Items> _effects;
  @override
  List<Items> get effects {
    if (_effects is EqualUnmodifiableListView) return _effects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_effects);
  }

  @override
  String toString() {
    return 'LevelEvent.changeSpeed(speed: $speed, effects: $effects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeSpeed &&
            (identical(other.speed, speed) || other.speed == speed) &&
            const DeepCollectionEquality().equals(other._effects, _effects));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, speed, const DeepCollectionEquality().hash(_effects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeSpeedCopyWith<_$_ChangeSpeed> get copyWith =>
      __$$_ChangeSpeedCopyWithImpl<_$_ChangeSpeed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return changeSpeed(speed, effects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return changeSpeed?.call(speed, effects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (changeSpeed != null) {
      return changeSpeed(speed, effects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return changeSpeed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return changeSpeed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (changeSpeed != null) {
      return changeSpeed(this);
    }
    return orElse();
  }
}

abstract class _ChangeSpeed implements LevelEvent {
  const factory _ChangeSpeed(
      {required final double speed,
      required final List<Items> effects}) = _$_ChangeSpeed;

  double get speed;
  List<Items> get effects;
  @JsonKey(ignore: true)
  _$$_ChangeSpeedCopyWith<_$_ChangeSpeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FinishFigureCopyWith<$Res> {
  factory _$$_FinishFigureCopyWith(
          _$_FinishFigure value, $Res Function(_$_FinishFigure) then) =
      __$$_FinishFigureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_FinishFigureCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_FinishFigure>
    implements _$$_FinishFigureCopyWith<$Res> {
  __$$_FinishFigureCopyWithImpl(
      _$_FinishFigure _value, $Res Function(_$_FinishFigure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_FinishFigure implements _FinishFigure {
  const _$_FinishFigure();

  @override
  String toString() {
    return 'LevelEvent.finishFigure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_FinishFigure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level, List<Items> effects) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(MiniGame game) startMiniGame,
    required TResult Function() finishMiniGame,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function(double speed, List<Items> effects) changeSpeed,
    required TResult Function() finishFigure,
  }) {
    return finishFigure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level, List<Items> effects)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(MiniGame game)? startMiniGame,
    TResult? Function()? finishMiniGame,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function(double speed, List<Items> effects)? changeSpeed,
    TResult? Function()? finishFigure,
  }) {
    return finishFigure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level, List<Items> effects)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(MiniGame game)? startMiniGame,
    TResult Function()? finishMiniGame,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function(double speed, List<Items> effects)? changeSpeed,
    TResult Function()? finishFigure,
    required TResult orElse(),
  }) {
    if (finishFigure != null) {
      return finishFigure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartMiniGame value) startMiniGame,
    required TResult Function(_FinishMiniGame value) finishMiniGame,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_ChangeSpeed value) changeSpeed,
    required TResult Function(_FinishFigure value) finishFigure,
  }) {
    return finishFigure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartMiniGame value)? startMiniGame,
    TResult? Function(_FinishMiniGame value)? finishMiniGame,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_ChangeSpeed value)? changeSpeed,
    TResult? Function(_FinishFigure value)? finishFigure,
  }) {
    return finishFigure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartMiniGame value)? startMiniGame,
    TResult Function(_FinishMiniGame value)? finishMiniGame,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_ChangeSpeed value)? changeSpeed,
    TResult Function(_FinishFigure value)? finishFigure,
    required TResult orElse(),
  }) {
    if (finishFigure != null) {
      return finishFigure(this);
    }
    return orElse();
  }
}

abstract class _FinishFigure implements LevelEvent {
  const factory _FinishFigure() = _$_FinishFigure;
}

/// @nodoc
mixin _$FigureEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FigureEventCopyWith<$Res> {
  factory $FigureEventCopyWith(
          FigureEvent value, $Res Function(FigureEvent) then) =
      _$FigureEventCopyWithImpl<$Res, FigureEvent>;
}

/// @nodoc
class _$FigureEventCopyWithImpl<$Res, $Val extends FigureEvent>
    implements $FigureEventCopyWith<$Res> {
  _$FigureEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_TrashWallCopyWith<$Res> {
  factory _$$_TrashWallCopyWith(
          _$_TrashWall value, $Res Function(_$_TrashWall) then) =
      __$$_TrashWallCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TrashWallCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_TrashWall>
    implements _$$_TrashWallCopyWith<$Res> {
  __$$_TrashWallCopyWithImpl(
      _$_TrashWall _value, $Res Function(_$_TrashWall) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TrashWall implements _TrashWall {
  const _$_TrashWall();

  @override
  String toString() {
    return 'FigureEvent.trashWall()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_TrashWall);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return trashWall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return trashWall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (trashWall != null) {
      return trashWall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return trashWall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return trashWall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (trashWall != null) {
      return trashWall(this);
    }
    return orElse();
  }
}

abstract class _TrashWall implements FigureEvent {
  const factory _TrashWall() = _$_TrashWall;
}

/// @nodoc
abstract class _$$_GuardedPizzaCopyWith<$Res> {
  factory _$$_GuardedPizzaCopyWith(
          _$_GuardedPizza value, $Res Function(_$_GuardedPizza) then) =
      __$$_GuardedPizzaCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GuardedPizzaCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_GuardedPizza>
    implements _$$_GuardedPizzaCopyWith<$Res> {
  __$$_GuardedPizzaCopyWithImpl(
      _$_GuardedPizza _value, $Res Function(_$_GuardedPizza) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_GuardedPizza implements _GuardedPizza {
  const _$_GuardedPizza();

  @override
  String toString() {
    return 'FigureEvent.guardedPizza()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_GuardedPizza);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return guardedPizza();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return guardedPizza?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (guardedPizza != null) {
      return guardedPizza();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return guardedPizza(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return guardedPizza?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (guardedPizza != null) {
      return guardedPizza(this);
    }
    return orElse();
  }
}

abstract class _GuardedPizza implements FigureEvent {
  const factory _GuardedPizza() = _$_GuardedPizza;
}

/// @nodoc
abstract class _$$_CursedPathCopyWith<$Res> {
  factory _$$_CursedPathCopyWith(
          _$_CursedPath value, $Res Function(_$_CursedPath) then) =
      __$$_CursedPathCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_CursedPathCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_CursedPath>
    implements _$$_CursedPathCopyWith<$Res> {
  __$$_CursedPathCopyWithImpl(
      _$_CursedPath _value, $Res Function(_$_CursedPath) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_CursedPath implements _CursedPath {
  const _$_CursedPath();

  @override
  String toString() {
    return 'FigureEvent.cursedPath()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_CursedPath);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return cursedPath();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return cursedPath?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (cursedPath != null) {
      return cursedPath();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return cursedPath(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return cursedPath?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (cursedPath != null) {
      return cursedPath(this);
    }
    return orElse();
  }
}

abstract class _CursedPath implements FigureEvent {
  const factory _CursedPath() = _$_CursedPath;
}

/// @nodoc
abstract class _$$_PunchWaveCopyWith<$Res> {
  factory _$$_PunchWaveCopyWith(
          _$_PunchWave value, $Res Function(_$_PunchWave) then) =
      __$$_PunchWaveCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PunchWaveCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_PunchWave>
    implements _$$_PunchWaveCopyWith<$Res> {
  __$$_PunchWaveCopyWithImpl(
      _$_PunchWave _value, $Res Function(_$_PunchWave) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_PunchWave implements _PunchWave {
  const _$_PunchWave();

  @override
  String toString() {
    return 'FigureEvent.punchWave()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_PunchWave);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return punchWave();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return punchWave?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (punchWave != null) {
      return punchWave();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return punchWave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return punchWave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (punchWave != null) {
      return punchWave(this);
    }
    return orElse();
  }
}

abstract class _PunchWave implements FigureEvent {
  const factory _PunchWave() = _$_PunchWave;
}

/// @nodoc
abstract class _$$_BigBuddyBinCopyWith<$Res> {
  factory _$$_BigBuddyBinCopyWith(
          _$_BigBuddyBin value, $Res Function(_$_BigBuddyBin) then) =
      __$$_BigBuddyBinCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_BigBuddyBinCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_BigBuddyBin>
    implements _$$_BigBuddyBinCopyWith<$Res> {
  __$$_BigBuddyBinCopyWithImpl(
      _$_BigBuddyBin _value, $Res Function(_$_BigBuddyBin) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_BigBuddyBin implements _BigBuddyBin {
  const _$_BigBuddyBin();

  @override
  String toString() {
    return 'FigureEvent.bigBuddyBin()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_BigBuddyBin);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return bigBuddyBin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return bigBuddyBin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (bigBuddyBin != null) {
      return bigBuddyBin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return bigBuddyBin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return bigBuddyBin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (bigBuddyBin != null) {
      return bigBuddyBin(this);
    }
    return orElse();
  }
}

abstract class _BigBuddyBin implements FigureEvent {
  const factory _BigBuddyBin() = _$_BigBuddyBin;
}

/// @nodoc
abstract class _$$_UnreachablePizzaCopyWith<$Res> {
  factory _$$_UnreachablePizzaCopyWith(
          _$_UnreachablePizza value, $Res Function(_$_UnreachablePizza) then) =
      __$$_UnreachablePizzaCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnreachablePizzaCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_UnreachablePizza>
    implements _$$_UnreachablePizzaCopyWith<$Res> {
  __$$_UnreachablePizzaCopyWithImpl(
      _$_UnreachablePizza _value, $Res Function(_$_UnreachablePizza) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_UnreachablePizza implements _UnreachablePizza {
  const _$_UnreachablePizza();

  @override
  String toString() {
    return 'FigureEvent.unreachablePizza()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_UnreachablePizza);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return unreachablePizza();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return unreachablePizza?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (unreachablePizza != null) {
      return unreachablePizza();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return unreachablePizza(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return unreachablePizza?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (unreachablePizza != null) {
      return unreachablePizza(this);
    }
    return orElse();
  }
}

abstract class _UnreachablePizza implements FigureEvent {
  const factory _UnreachablePizza() = _$_UnreachablePizza;
}

/// @nodoc
abstract class _$$_Only2TimesCopyWith<$Res> {
  factory _$$_Only2TimesCopyWith(
          _$_Only2Times value, $Res Function(_$_Only2Times) then) =
      __$$_Only2TimesCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_Only2TimesCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_Only2Times>
    implements _$$_Only2TimesCopyWith<$Res> {
  __$$_Only2TimesCopyWithImpl(
      _$_Only2Times _value, $Res Function(_$_Only2Times) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Only2Times implements _Only2Times {
  const _$_Only2Times();

  @override
  String toString() {
    return 'FigureEvent.only2Lines()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Only2Times);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return only2Lines();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return only2Lines?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (only2Lines != null) {
      return only2Lines();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return only2Lines(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return only2Lines?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (only2Lines != null) {
      return only2Lines(this);
    }
    return orElse();
  }
}

abstract class _Only2Times implements FigureEvent {
  const factory _Only2Times() = _$_Only2Times;
}

/// @nodoc
abstract class _$$_SlowMoCopyWith<$Res> {
  factory _$$_SlowMoCopyWith(_$_SlowMo value, $Res Function(_$_SlowMo) then) =
      __$$_SlowMoCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SlowMoCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_SlowMo>
    implements _$$_SlowMoCopyWith<$Res> {
  __$$_SlowMoCopyWithImpl(_$_SlowMo _value, $Res Function(_$_SlowMo) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SlowMo implements _SlowMo {
  const _$_SlowMo();

  @override
  String toString() {
    return 'FigureEvent.slowMo()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SlowMo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return slowMo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return slowMo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (slowMo != null) {
      return slowMo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return slowMo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return slowMo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (slowMo != null) {
      return slowMo(this);
    }
    return orElse();
  }
}

abstract class _SlowMo implements FigureEvent {
  const factory _SlowMo() = _$_SlowMo;
}

/// @nodoc
abstract class _$$_WinLabelCopyWith<$Res> {
  factory _$$_WinLabelCopyWith(
          _$_WinLabel value, $Res Function(_$_WinLabel) then) =
      __$$_WinLabelCopyWithImpl<$Res>;
  @useResult
  $Res call({Items item});
}

/// @nodoc
class __$$_WinLabelCopyWithImpl<$Res>
    extends _$FigureEventCopyWithImpl<$Res, _$_WinLabel>
    implements _$$_WinLabelCopyWith<$Res> {
  __$$_WinLabelCopyWithImpl(
      _$_WinLabel _value, $Res Function(_$_WinLabel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$_WinLabel(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Items,
    ));
  }
}

/// @nodoc

class _$_WinLabel implements _WinLabel {
  const _$_WinLabel({required this.item});

  @override
  final Items item;

  @override
  String toString() {
    return 'FigureEvent.winLabel(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WinLabel &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WinLabelCopyWith<_$_WinLabel> get copyWith =>
      __$$_WinLabelCopyWithImpl<_$_WinLabel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
    required TResult Function() punchWave,
    required TResult Function() bigBuddyBin,
    required TResult Function() unreachablePizza,
    required TResult Function() only2Lines,
    required TResult Function() slowMo,
    required TResult Function(Items item) winLabel,
  }) {
    return winLabel(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
    TResult? Function()? punchWave,
    TResult? Function()? bigBuddyBin,
    TResult? Function()? unreachablePizza,
    TResult? Function()? only2Lines,
    TResult? Function()? slowMo,
    TResult? Function(Items item)? winLabel,
  }) {
    return winLabel?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    TResult Function()? punchWave,
    TResult Function()? bigBuddyBin,
    TResult Function()? unreachablePizza,
    TResult Function()? only2Lines,
    TResult Function()? slowMo,
    TResult Function(Items item)? winLabel,
    required TResult orElse(),
  }) {
    if (winLabel != null) {
      return winLabel(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
    required TResult Function(_PunchWave value) punchWave,
    required TResult Function(_BigBuddyBin value) bigBuddyBin,
    required TResult Function(_UnreachablePizza value) unreachablePizza,
    required TResult Function(_Only2Times value) only2Lines,
    required TResult Function(_SlowMo value) slowMo,
    required TResult Function(_WinLabel value) winLabel,
  }) {
    return winLabel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
    TResult? Function(_PunchWave value)? punchWave,
    TResult? Function(_BigBuddyBin value)? bigBuddyBin,
    TResult? Function(_UnreachablePizza value)? unreachablePizza,
    TResult? Function(_Only2Times value)? only2Lines,
    TResult? Function(_SlowMo value)? slowMo,
    TResult? Function(_WinLabel value)? winLabel,
  }) {
    return winLabel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
    TResult Function(_PunchWave value)? punchWave,
    TResult Function(_BigBuddyBin value)? bigBuddyBin,
    TResult Function(_UnreachablePizza value)? unreachablePizza,
    TResult Function(_Only2Times value)? only2Lines,
    TResult Function(_SlowMo value)? slowMo,
    TResult Function(_WinLabel value)? winLabel,
    required TResult orElse(),
  }) {
    if (winLabel != null) {
      return winLabel(this);
    }
    return orElse();
  }
}

abstract class _WinLabel implements FigureEvent {
  const factory _WinLabel({required final Items item}) = _$_WinLabel;

  Items get item;
  @JsonKey(ignore: true)
  _$$_WinLabelCopyWith<_$_WinLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LevelState {
  LinearLevel get level => throw _privateConstructorUsedError;
  FigureEvent? get figure => throw _privateConstructorUsedError;
  MiniGame? get miniGame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LevelStateCopyWith<LevelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelStateCopyWith<$Res> {
  factory $LevelStateCopyWith(
          LevelState value, $Res Function(LevelState) then) =
      _$LevelStateCopyWithImpl<$Res, LevelState>;
  @useResult
  $Res call({LinearLevel level, FigureEvent? figure, MiniGame? miniGame});

  $FigureEventCopyWith<$Res>? get figure;
  $MiniGameCopyWith<$Res>? get miniGame;
}

/// @nodoc
class _$LevelStateCopyWithImpl<$Res, $Val extends LevelState>
    implements $LevelStateCopyWith<$Res> {
  _$LevelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? figure = freezed,
    Object? miniGame = freezed,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as LinearLevel,
      figure: freezed == figure
          ? _value.figure
          : figure // ignore: cast_nullable_to_non_nullable
              as FigureEvent?,
      miniGame: freezed == miniGame
          ? _value.miniGame
          : miniGame // ignore: cast_nullable_to_non_nullable
              as MiniGame?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FigureEventCopyWith<$Res>? get figure {
    if (_value.figure == null) {
      return null;
    }

    return $FigureEventCopyWith<$Res>(_value.figure!, (value) {
      return _then(_value.copyWith(figure: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MiniGameCopyWith<$Res>? get miniGame {
    if (_value.miniGame == null) {
      return null;
    }

    return $MiniGameCopyWith<$Res>(_value.miniGame!, (value) {
      return _then(_value.copyWith(miniGame: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LevelStateCopyWith<$Res>
    implements $LevelStateCopyWith<$Res> {
  factory _$$_LevelStateCopyWith(
          _$_LevelState value, $Res Function(_$_LevelState) then) =
      __$$_LevelStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LinearLevel level, FigureEvent? figure, MiniGame? miniGame});

  @override
  $FigureEventCopyWith<$Res>? get figure;
  @override
  $MiniGameCopyWith<$Res>? get miniGame;
}

/// @nodoc
class __$$_LevelStateCopyWithImpl<$Res>
    extends _$LevelStateCopyWithImpl<$Res, _$_LevelState>
    implements _$$_LevelStateCopyWith<$Res> {
  __$$_LevelStateCopyWithImpl(
      _$_LevelState _value, $Res Function(_$_LevelState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? figure = freezed,
    Object? miniGame = freezed,
  }) {
    return _then(_$_LevelState(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as LinearLevel,
      figure: freezed == figure
          ? _value.figure
          : figure // ignore: cast_nullable_to_non_nullable
              as FigureEvent?,
      miniGame: freezed == miniGame
          ? _value.miniGame
          : miniGame // ignore: cast_nullable_to_non_nullable
              as MiniGame?,
    ));
  }
}

/// @nodoc

class _$_LevelState implements _LevelState {
  const _$_LevelState({required this.level, this.figure, this.miniGame});

  @override
  final LinearLevel level;
  @override
  final FigureEvent? figure;
  @override
  final MiniGame? miniGame;

  @override
  String toString() {
    return 'LevelState(level: $level, figure: $figure, miniGame: $miniGame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelState &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.figure, figure) || other.figure == figure) &&
            (identical(other.miniGame, miniGame) ||
                other.miniGame == miniGame));
  }

  @override
  int get hashCode => Object.hash(runtimeType, level, figure, miniGame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LevelStateCopyWith<_$_LevelState> get copyWith =>
      __$$_LevelStateCopyWithImpl<_$_LevelState>(this, _$identity);
}

abstract class _LevelState implements LevelState {
  const factory _LevelState(
      {required final LinearLevel level,
      final FigureEvent? figure,
      final MiniGame? miniGame}) = _$_LevelState;

  @override
  LinearLevel get level;
  @override
  FigureEvent? get figure;
  @override
  MiniGame? get miniGame;
  @override
  @JsonKey(ignore: true)
  _$$_LevelStateCopyWith<_$_LevelState> get copyWith =>
      throw _privateConstructorUsedError;
}
