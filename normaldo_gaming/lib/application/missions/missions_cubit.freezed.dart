// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'missions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MissionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MissionsFailure failure) failed,
    required TResult Function(Map<Mission, int> progress) success,
    required TResult Function((int, Mission) replacement) replaced,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MissionsFailure failure)? failed,
    TResult? Function(Map<Mission, int> progress)? success,
    TResult? Function((int, Mission) replacement)? replaced,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MissionsFailure failure)? failed,
    TResult Function(Map<Mission, int> progress)? success,
    TResult Function((int, Mission) replacement)? replaced,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
    required TResult Function(_Replaced value) replaced,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Success value)? success,
    TResult? Function(_Replaced value)? replaced,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    TResult Function(_Replaced value)? replaced,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionsStateCopyWith<$Res> {
  factory $MissionsStateCopyWith(
          MissionsState value, $Res Function(MissionsState) then) =
      _$MissionsStateCopyWithImpl<$Res, MissionsState>;
}

/// @nodoc
class _$MissionsStateCopyWithImpl<$Res, $Val extends MissionsState>
    implements $MissionsStateCopyWith<$Res> {
  _$MissionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$MissionsStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'MissionsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MissionsFailure failure) failed,
    required TResult Function(Map<Mission, int> progress) success,
    required TResult Function((int, Mission) replacement) replaced,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MissionsFailure failure)? failed,
    TResult? Function(Map<Mission, int> progress)? success,
    TResult? Function((int, Mission) replacement)? replaced,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MissionsFailure failure)? failed,
    TResult Function(Map<Mission, int> progress)? success,
    TResult Function((int, Mission) replacement)? replaced,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
    required TResult Function(_Replaced value) replaced,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Success value)? success,
    TResult? Function(_Replaced value)? replaced,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    TResult Function(_Replaced value)? replaced,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MissionsState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$MissionsStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'MissionsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MissionsFailure failure) failed,
    required TResult Function(Map<Mission, int> progress) success,
    required TResult Function((int, Mission) replacement) replaced,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MissionsFailure failure)? failed,
    TResult? Function(Map<Mission, int> progress)? success,
    TResult? Function((int, Mission) replacement)? replaced,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MissionsFailure failure)? failed,
    TResult Function(Map<Mission, int> progress)? success,
    TResult Function((int, Mission) replacement)? replaced,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
    required TResult Function(_Replaced value) replaced,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Success value)? success,
    TResult? Function(_Replaced value)? replaced,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    TResult Function(_Replaced value)? replaced,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MissionsState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_FailedCopyWith<$Res> {
  factory _$$_FailedCopyWith(_$_Failed value, $Res Function(_$_Failed) then) =
      __$$_FailedCopyWithImpl<$Res>;
  @useResult
  $Res call({MissionsFailure failure});
}

/// @nodoc
class __$$_FailedCopyWithImpl<$Res>
    extends _$MissionsStateCopyWithImpl<$Res, _$_Failed>
    implements _$$_FailedCopyWith<$Res> {
  __$$_FailedCopyWithImpl(_$_Failed _value, $Res Function(_$_Failed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$_Failed(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as MissionsFailure,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed({required this.failure});

  @override
  final MissionsFailure failure;

  @override
  String toString() {
    return 'MissionsState.failed(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Failed &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FailedCopyWith<_$_Failed> get copyWith =>
      __$$_FailedCopyWithImpl<_$_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MissionsFailure failure) failed,
    required TResult Function(Map<Mission, int> progress) success,
    required TResult Function((int, Mission) replacement) replaced,
  }) {
    return failed(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MissionsFailure failure)? failed,
    TResult? Function(Map<Mission, int> progress)? success,
    TResult? Function((int, Mission) replacement)? replaced,
  }) {
    return failed?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MissionsFailure failure)? failed,
    TResult Function(Map<Mission, int> progress)? success,
    TResult Function((int, Mission) replacement)? replaced,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
    required TResult Function(_Replaced value) replaced,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Success value)? success,
    TResult? Function(_Replaced value)? replaced,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    TResult Function(_Replaced value)? replaced,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements MissionsState {
  const factory _Failed({required final MissionsFailure failure}) = _$_Failed;

  MissionsFailure get failure;
  @JsonKey(ignore: true)
  _$$_FailedCopyWith<_$_Failed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<Mission, int> progress});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$MissionsStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
  }) {
    return _then(_$_Success(
      progress: null == progress
          ? _value._progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Map<Mission, int>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success({required final Map<Mission, int> progress})
      : _progress = progress;

  final Map<Mission, int> _progress;
  @override
  Map<Mission, int> get progress {
    if (_progress is EqualUnmodifiableMapView) return _progress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_progress);
  }

  @override
  String toString() {
    return 'MissionsState.success(progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success &&
            const DeepCollectionEquality().equals(other._progress, _progress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_progress));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      __$$_SuccessCopyWithImpl<_$_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MissionsFailure failure) failed,
    required TResult Function(Map<Mission, int> progress) success,
    required TResult Function((int, Mission) replacement) replaced,
  }) {
    return success(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MissionsFailure failure)? failed,
    TResult? Function(Map<Mission, int> progress)? success,
    TResult? Function((int, Mission) replacement)? replaced,
  }) {
    return success?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MissionsFailure failure)? failed,
    TResult Function(Map<Mission, int> progress)? success,
    TResult Function((int, Mission) replacement)? replaced,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
    required TResult Function(_Replaced value) replaced,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Success value)? success,
    TResult? Function(_Replaced value)? replaced,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    TResult Function(_Replaced value)? replaced,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements MissionsState {
  const factory _Success({required final Map<Mission, int> progress}) =
      _$_Success;

  Map<Mission, int> get progress;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ReplacedCopyWith<$Res> {
  factory _$$_ReplacedCopyWith(
          _$_Replaced value, $Res Function(_$_Replaced) then) =
      __$$_ReplacedCopyWithImpl<$Res>;
  @useResult
  $Res call({(int, Mission) replacement});
}

/// @nodoc
class __$$_ReplacedCopyWithImpl<$Res>
    extends _$MissionsStateCopyWithImpl<$Res, _$_Replaced>
    implements _$$_ReplacedCopyWith<$Res> {
  __$$_ReplacedCopyWithImpl(
      _$_Replaced _value, $Res Function(_$_Replaced) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replacement = null,
  }) {
    return _then(_$_Replaced(
      replacement: null == replacement
          ? _value.replacement
          : replacement // ignore: cast_nullable_to_non_nullable
              as (int, Mission),
    ));
  }
}

/// @nodoc

class _$_Replaced implements _Replaced {
  const _$_Replaced({required this.replacement});

  @override
  final (int, Mission) replacement;

  @override
  String toString() {
    return 'MissionsState.replaced(replacement: $replacement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Replaced &&
            (identical(other.replacement, replacement) ||
                other.replacement == replacement));
  }

  @override
  int get hashCode => Object.hash(runtimeType, replacement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReplacedCopyWith<_$_Replaced> get copyWith =>
      __$$_ReplacedCopyWithImpl<_$_Replaced>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MissionsFailure failure) failed,
    required TResult Function(Map<Mission, int> progress) success,
    required TResult Function((int, Mission) replacement) replaced,
  }) {
    return replaced(replacement);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MissionsFailure failure)? failed,
    TResult? Function(Map<Mission, int> progress)? success,
    TResult? Function((int, Mission) replacement)? replaced,
  }) {
    return replaced?.call(replacement);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MissionsFailure failure)? failed,
    TResult Function(Map<Mission, int> progress)? success,
    TResult Function((int, Mission) replacement)? replaced,
    required TResult orElse(),
  }) {
    if (replaced != null) {
      return replaced(replacement);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
    required TResult Function(_Replaced value) replaced,
  }) {
    return replaced(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Success value)? success,
    TResult? Function(_Replaced value)? replaced,
  }) {
    return replaced?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    TResult Function(_Replaced value)? replaced,
    required TResult orElse(),
  }) {
    if (replaced != null) {
      return replaced(this);
    }
    return orElse();
  }
}

abstract class _Replaced implements MissionsState {
  const factory _Replaced({required final (int, Mission) replacement}) =
      _$_Replaced;

  (int, Mission) get replacement;
  @JsonKey(ignore: true)
  _$$_ReplacedCopyWith<_$_Replaced> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MissionsState2 {
  bool get loading => throw _privateConstructorUsedError;
  List<Mission> get missions => throw _privateConstructorUsedError;
  List<Mission> get completed => throw _privateConstructorUsedError;
  MissionsFailure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MissionsState2CopyWith<MissionsState2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionsState2CopyWith<$Res> {
  factory $MissionsState2CopyWith(
          MissionsState2 value, $Res Function(MissionsState2) then) =
      _$MissionsState2CopyWithImpl<$Res, MissionsState2>;
  @useResult
  $Res call(
      {bool loading,
      List<Mission> missions,
      List<Mission> completed,
      MissionsFailure? failure});
}

/// @nodoc
class _$MissionsState2CopyWithImpl<$Res, $Val extends MissionsState2>
    implements $MissionsState2CopyWith<$Res> {
  _$MissionsState2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? missions = null,
    Object? completed = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      missions: null == missions
          ? _value.missions
          : missions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as MissionsFailure?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MissionsState2CopyWith<$Res>
    implements $MissionsState2CopyWith<$Res> {
  factory _$$_MissionsState2CopyWith(
          _$_MissionsState2 value, $Res Function(_$_MissionsState2) then) =
      __$$_MissionsState2CopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      List<Mission> missions,
      List<Mission> completed,
      MissionsFailure? failure});
}

/// @nodoc
class __$$_MissionsState2CopyWithImpl<$Res>
    extends _$MissionsState2CopyWithImpl<$Res, _$_MissionsState2>
    implements _$$_MissionsState2CopyWith<$Res> {
  __$$_MissionsState2CopyWithImpl(
      _$_MissionsState2 _value, $Res Function(_$_MissionsState2) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? missions = null,
    Object? completed = null,
    Object? failure = freezed,
  }) {
    return _then(_$_MissionsState2(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      missions: null == missions
          ? _value._missions
          : missions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
      completed: null == completed
          ? _value._completed
          : completed // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as MissionsFailure?,
    ));
  }
}

/// @nodoc

class _$_MissionsState2 implements _MissionsState2 {
  const _$_MissionsState2(
      {required this.loading,
      required final List<Mission> missions,
      required final List<Mission> completed,
      this.failure})
      : _missions = missions,
        _completed = completed;

  @override
  final bool loading;
  final List<Mission> _missions;
  @override
  List<Mission> get missions {
    if (_missions is EqualUnmodifiableListView) return _missions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missions);
  }

  final List<Mission> _completed;
  @override
  List<Mission> get completed {
    if (_completed is EqualUnmodifiableListView) return _completed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completed);
  }

  @override
  final MissionsFailure? failure;

  @override
  String toString() {
    return 'MissionsState2(loading: $loading, missions: $missions, completed: $completed, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MissionsState2 &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._missions, _missions) &&
            const DeepCollectionEquality()
                .equals(other._completed, _completed) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      const DeepCollectionEquality().hash(_missions),
      const DeepCollectionEquality().hash(_completed),
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MissionsState2CopyWith<_$_MissionsState2> get copyWith =>
      __$$_MissionsState2CopyWithImpl<_$_MissionsState2>(this, _$identity);
}

abstract class _MissionsState2 implements MissionsState2 {
  const factory _MissionsState2(
      {required final bool loading,
      required final List<Mission> missions,
      required final List<Mission> completed,
      final MissionsFailure? failure}) = _$_MissionsState2;

  @override
  bool get loading;
  @override
  List<Mission> get missions;
  @override
  List<Mission> get completed;
  @override
  MissionsFailure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$_MissionsState2CopyWith<_$_MissionsState2> get copyWith =>
      throw _privateConstructorUsedError;
}
