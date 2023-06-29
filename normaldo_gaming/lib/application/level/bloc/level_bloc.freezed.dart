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
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
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
  $Res call({int level});
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
  }) {
    return _then(_$_ChangeLevel(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChangeLevel implements _ChangeLevel {
  const _$_ChangeLevel({required this.level});

  @override
  final int level;

  @override
  String toString() {
    return 'LevelEvent.changeLevel(level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeLevel &&
            (identical(other.level, level) || other.level == level));
  }

  @override
  int get hashCode => Object.hash(runtimeType, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeLevelCopyWith<_$_ChangeLevel> get copyWith =>
      __$$_ChangeLevelCopyWithImpl<_$_ChangeLevel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) {
    return changeLevel(level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) {
    return changeLevel?.call(level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
    required TResult orElse(),
  }) {
    if (changeLevel != null) {
      return changeLevel(level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) {
    return changeLevel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) {
    return changeLevel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
    required TResult orElse(),
  }) {
    if (changeLevel != null) {
      return changeLevel(this);
    }
    return orElse();
  }
}

abstract class _ChangeLevel implements LevelEvent {
  const factory _ChangeLevel({required final int level}) = _$_ChangeLevel;

  int get level;
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
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) {
    return startFigure(figure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) {
    return startFigure?.call(figure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
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
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) {
    return startFigure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) {
    return startFigure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
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
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) {
    return startRandomFigure(figures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) {
    return startRandomFigure?.call(figures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
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
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) {
    return startRandomFigure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) {
    return startRandomFigure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
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
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) {
    return finishFigure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) {
    return finishFigure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
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
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) {
    return finishFigure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) {
    return finishFigure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
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
abstract class _$$_AddEffectCopyWith<$Res> {
  factory _$$_AddEffectCopyWith(
          _$_AddEffect value, $Res Function(_$_AddEffect) then) =
      __$$_AddEffectCopyWithImpl<$Res>;
  @useResult
  $Res call({int timestamp, Items item, double duration});
}

/// @nodoc
class __$$_AddEffectCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_AddEffect>
    implements _$$_AddEffectCopyWith<$Res> {
  __$$_AddEffectCopyWithImpl(
      _$_AddEffect _value, $Res Function(_$_AddEffect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? item = null,
    Object? duration = null,
  }) {
    return _then(_$_AddEffect(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Items,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_AddEffect implements _AddEffect {
  const _$_AddEffect(
      {required this.timestamp, required this.item, required this.duration});

  @override
  final int timestamp;
  @override
  final Items item;
  @override
  final double duration;

  @override
  String toString() {
    return 'LevelEvent.addEffect(timestamp: $timestamp, item: $item, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddEffect &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, item, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddEffectCopyWith<_$_AddEffect> get copyWith =>
      __$$_AddEffectCopyWithImpl<_$_AddEffect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) {
    return addEffect(timestamp, item, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) {
    return addEffect?.call(timestamp, item, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
    required TResult orElse(),
  }) {
    if (addEffect != null) {
      return addEffect(timestamp, item, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) {
    return addEffect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) {
    return addEffect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
    required TResult orElse(),
  }) {
    if (addEffect != null) {
      return addEffect(this);
    }
    return orElse();
  }
}

abstract class _AddEffect implements LevelEvent {
  const factory _AddEffect(
      {required final int timestamp,
      required final Items item,
      required final double duration}) = _$_AddEffect;

  int get timestamp;
  Items get item;
  double get duration;
  @JsonKey(ignore: true)
  _$$_AddEffectCopyWith<_$_AddEffect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RemoveEffectCopyWith<$Res> {
  factory _$$_RemoveEffectCopyWith(
          _$_RemoveEffect value, $Res Function(_$_RemoveEffect) then) =
      __$$_RemoveEffectCopyWithImpl<$Res>;
  @useResult
  $Res call({Items item});
}

/// @nodoc
class __$$_RemoveEffectCopyWithImpl<$Res>
    extends _$LevelEventCopyWithImpl<$Res, _$_RemoveEffect>
    implements _$$_RemoveEffectCopyWith<$Res> {
  __$$_RemoveEffectCopyWithImpl(
      _$_RemoveEffect _value, $Res Function(_$_RemoveEffect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$_RemoveEffect(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Items,
    ));
  }
}

/// @nodoc

class _$_RemoveEffect implements _RemoveEffect {
  const _$_RemoveEffect({required this.item});

  @override
  final Items item;

  @override
  String toString() {
    return 'LevelEvent.removeEffect(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoveEffect &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoveEffectCopyWith<_$_RemoveEffect> get copyWith =>
      __$$_RemoveEffectCopyWithImpl<_$_RemoveEffect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int level) changeLevel,
    required TResult Function(FigureEvent figure) startFigure,
    required TResult Function(List<FigureEvent>? figures) startRandomFigure,
    required TResult Function() finishFigure,
    required TResult Function(int timestamp, Items item, double duration)
        addEffect,
    required TResult Function(Items item) removeEffect,
  }) {
    return removeEffect(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int level)? changeLevel,
    TResult? Function(FigureEvent figure)? startFigure,
    TResult? Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult? Function()? finishFigure,
    TResult? Function(int timestamp, Items item, double duration)? addEffect,
    TResult? Function(Items item)? removeEffect,
  }) {
    return removeEffect?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int level)? changeLevel,
    TResult Function(FigureEvent figure)? startFigure,
    TResult Function(List<FigureEvent>? figures)? startRandomFigure,
    TResult Function()? finishFigure,
    TResult Function(int timestamp, Items item, double duration)? addEffect,
    TResult Function(Items item)? removeEffect,
    required TResult orElse(),
  }) {
    if (removeEffect != null) {
      return removeEffect(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChangeLevel value) changeLevel,
    required TResult Function(_StartFigure value) startFigure,
    required TResult Function(_StartRandomFigure value) startRandomFigure,
    required TResult Function(_FinishFigure value) finishFigure,
    required TResult Function(_AddEffect value) addEffect,
    required TResult Function(_RemoveEffect value) removeEffect,
  }) {
    return removeEffect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChangeLevel value)? changeLevel,
    TResult? Function(_StartFigure value)? startFigure,
    TResult? Function(_StartRandomFigure value)? startRandomFigure,
    TResult? Function(_FinishFigure value)? finishFigure,
    TResult? Function(_AddEffect value)? addEffect,
    TResult? Function(_RemoveEffect value)? removeEffect,
  }) {
    return removeEffect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChangeLevel value)? changeLevel,
    TResult Function(_StartFigure value)? startFigure,
    TResult Function(_StartRandomFigure value)? startRandomFigure,
    TResult Function(_FinishFigure value)? finishFigure,
    TResult Function(_AddEffect value)? addEffect,
    TResult Function(_RemoveEffect value)? removeEffect,
    required TResult orElse(),
  }) {
    if (removeEffect != null) {
      return removeEffect(this);
    }
    return orElse();
  }
}

abstract class _RemoveEffect implements LevelEvent {
  const factory _RemoveEffect({required final Items item}) = _$_RemoveEffect;

  Items get item;
  @JsonKey(ignore: true)
  _$$_RemoveEffectCopyWith<_$_RemoveEffect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FigureEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() trashWall,
    required TResult Function() guardedPizza,
    required TResult Function() cursedPath,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TrashWall value) trashWall,
    required TResult Function(_GuardedPizza value) guardedPizza,
    required TResult Function(_CursedPath value) cursedPath,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
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
  }) {
    return trashWall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
  }) {
    return trashWall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
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
  }) {
    return trashWall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
  }) {
    return trashWall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
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
  }) {
    return guardedPizza();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
  }) {
    return guardedPizza?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
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
  }) {
    return guardedPizza(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
  }) {
    return guardedPizza?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
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
  }) {
    return cursedPath();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? trashWall,
    TResult? Function()? guardedPizza,
    TResult? Function()? cursedPath,
  }) {
    return cursedPath?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? trashWall,
    TResult Function()? guardedPizza,
    TResult Function()? cursedPath,
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
  }) {
    return cursedPath(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TrashWall value)? trashWall,
    TResult? Function(_GuardedPizza value)? guardedPizza,
    TResult? Function(_CursedPath value)? cursedPath,
  }) {
    return cursedPath?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TrashWall value)? trashWall,
    TResult Function(_GuardedPizza value)? guardedPizza,
    TResult Function(_CursedPath value)? cursedPath,
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
mixin _$LevelState {
  LinearLevel get level => throw _privateConstructorUsedError;

  /// timestamp => (item => duration)
  Map<int, MapEntry<Items, double>> get effects =>
      throw _privateConstructorUsedError;
  FigureEvent? get figure => throw _privateConstructorUsedError;

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
  $Res call(
      {LinearLevel level,
      Map<int, MapEntry<Items, double>> effects,
      FigureEvent? figure});

  $FigureEventCopyWith<$Res>? get figure;
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
    Object? effects = null,
    Object? figure = freezed,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as LinearLevel,
      effects: null == effects
          ? _value.effects
          : effects // ignore: cast_nullable_to_non_nullable
              as Map<int, MapEntry<Items, double>>,
      figure: freezed == figure
          ? _value.figure
          : figure // ignore: cast_nullable_to_non_nullable
              as FigureEvent?,
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
}

/// @nodoc
abstract class _$$_LevelStateCopyWith<$Res>
    implements $LevelStateCopyWith<$Res> {
  factory _$$_LevelStateCopyWith(
          _$_LevelState value, $Res Function(_$_LevelState) then) =
      __$$_LevelStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LinearLevel level,
      Map<int, MapEntry<Items, double>> effects,
      FigureEvent? figure});

  @override
  $FigureEventCopyWith<$Res>? get figure;
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
    Object? effects = null,
    Object? figure = freezed,
  }) {
    return _then(_$_LevelState(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as LinearLevel,
      effects: null == effects
          ? _value._effects
          : effects // ignore: cast_nullable_to_non_nullable
              as Map<int, MapEntry<Items, double>>,
      figure: freezed == figure
          ? _value.figure
          : figure // ignore: cast_nullable_to_non_nullable
              as FigureEvent?,
    ));
  }
}

/// @nodoc

class _$_LevelState implements _LevelState {
  const _$_LevelState(
      {required this.level,
      required final Map<int, MapEntry<Items, double>> effects,
      this.figure})
      : _effects = effects;

  @override
  final LinearLevel level;

  /// timestamp => (item => duration)
  final Map<int, MapEntry<Items, double>> _effects;

  /// timestamp => (item => duration)
  @override
  Map<int, MapEntry<Items, double>> get effects {
    if (_effects is EqualUnmodifiableMapView) return _effects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_effects);
  }

  @override
  final FigureEvent? figure;

  @override
  String toString() {
    return 'LevelState(level: $level, effects: $effects, figure: $figure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelState &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._effects, _effects) &&
            (identical(other.figure, figure) || other.figure == figure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, level,
      const DeepCollectionEquality().hash(_effects), figure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LevelStateCopyWith<_$_LevelState> get copyWith =>
      __$$_LevelStateCopyWithImpl<_$_LevelState>(this, _$identity);
}

abstract class _LevelState implements LevelState {
  const factory _LevelState(
      {required final LinearLevel level,
      required final Map<int, MapEntry<Items, double>> effects,
      final FigureEvent? figure}) = _$_LevelState;

  @override
  LinearLevel get level;
  @override

  /// timestamp => (item => duration)
  Map<int, MapEntry<Items, double>> get effects;
  @override
  FigureEvent? get figure;
  @override
  @JsonKey(ignore: true)
  _$$_LevelStateCopyWith<_$_LevelState> get copyWith =>
      throw _privateConstructorUsedError;
}
