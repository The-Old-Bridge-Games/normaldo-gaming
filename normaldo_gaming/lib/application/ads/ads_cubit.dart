import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:normaldo_gaming/domain/ads/ad_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

part 'ads_state.dart';
part 'ads_cubit.freezed.dart';

enum AdType { interstitial, rewarded }

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(const AdsState.initial());

  final _adManager = injector.get<BaseAdManager>();

  Future<void> showAd({
    required AdType type,
    required void Function() onComplete,
  }) async {
    emit(const AdsState.loading());
    final placementId = switch (type) {
      AdType.interstitial => _adManager.interstitialVideoAdPlacementId,
      AdType.rewarded => _adManager.rewardedVideoAdPlacementId,
    };
    if (await UnityAds.isInitialized()) {
      UnityAds.load(
          placementId: placementId,
          onComplete: (placementId) {
            emit(const AdsState.showing());
            UnityAds.showVideoAd(
              placementId: placementId,
              onStart: (placementId) {
                emit(const AdsState.showing());
              },
              onClick: (placementId) => print('Video Ad $placementId click'),
              onSkipped: (placementId) {
                emit(const AdsState.skipped());
              },
              onComplete: (placementId) {
                emit(AdsState.completed(onComplete: onComplete));
              },
              onFailed: (placementId, error, message) {
                emit(AdsState.failed(errorMessage: message));
                emit(const AdsState.initial());
              },
            );
          },
          onFailed: (placementId, error, errorMessage) {
            emit(AdsState.failed(errorMessage: errorMessage));
            emit(const AdsState.initial());
          });
    } else {
      emit(const AdsState.failed(errorMessage: 'Ads service not initialized'));
      emit(const AdsState.initial());
    }
  }
}
