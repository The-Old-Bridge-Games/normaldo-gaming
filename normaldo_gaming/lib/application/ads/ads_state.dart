part of 'ads_cubit.dart';

@freezed
class AdsState with _$AdsState {
  const factory AdsState.initial() = _Initial;
  const factory AdsState.loading() = _Loading;
  const factory AdsState.showing() = _Showing;
  const factory AdsState.failed({required String errorMessage}) = _Failed;
  const factory AdsState.skipped() = _Skipped;
  const factory AdsState.completed({required void Function() onComplete}) =
      _Completed;
}
