import 'dart:async';

import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/domain/ads/ad_manager.dart';
import 'package:normaldo_gaming/injection/injection.dart';
import 'package:normaldo_gaming/ui/pull_up_game/widgets/death_screen.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class PreDeathScreen extends StatefulWidget {
  const PreDeathScreen({super.key});

  @override
  State<PreDeathScreen> createState() => _PreDeathScreenState();
}

class _PreDeathScreenState extends State<PreDeathScreen> {
  double _opacity = 0.0;
  bool _loadingAd = false;
  double _skipValue = 1;
  Timer? _skipTimer;

  bool get showStats => _skipValue == 0;

  @override
  void initState() {
    super.initState();

    _skipTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_skipValue <= 0) {
        timer.cancel();
        _skipTimer = null;
        setState(() {
          _skipValue = 0;
        });
      } else if (!_loadingAd) {
        setState(() {
          _skipValue -= 0.2;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _skipTimer?.cancel();
    _skipTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (showStats) return const DeathScreen();
    return Scaffold(
      backgroundColor: NGTheme.bgSemiBlack,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: NGTheme.purple3, width: 3),
                ),
                child: BouncingButton(
                  onPressed: () async {
                    final placementId = injector
                        .get<BaseAdManager>()
                        .rewardedVideoAdPlacementId;
                    setState(() {
                      _loadingAd = true;
                    });
                    await UnityAds.load(
                        placementId: placementId,
                        onComplete: (placementId) {
                          setState(() {
                            _loadingAd = false;
                          });
                          UnityAds.showVideoAd(
                            placementId: placementId,
                            onStart: (placementId) =>
                                print('Video Ad $placementId started'),
                            onClick: (placementId) =>
                                print('Video Ad $placementId click'),
                            onSkipped: (placementId) =>
                                print('Video Ad $placementId skipped'),
                            onComplete: (placementId) =>
                                print('Video Ad $placementId completed'),
                            onFailed: (placementId, error, message) => print(
                                'Video Ad $placementId failed: $error $message'),
                          );
                        },
                        onFailed: (placementId, error, errorMessage) {
                          setState(() {
                            _loadingAd = false;
                            _skipValue = 0.0;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            errorMessage,
                            style: textTheme.displayMedium,
                          )));
                        });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/tv.png',
                        width: 100,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('+ 1', style: textTheme.displaySmall),
                          const SizedBox(width: 8),
                          Image.asset('assets/images/heart.png', width: 30)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.3, 0),
              child: _buildSkipButton(),
            ),
            Visibility(
              visible: _loadingAd,
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: BlinkingText(
                    'Loading your Ad...',
                    duration: const Duration(seconds: 1),
                    style: textTheme.displayMedium,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    final textTheme = Theme.of(context).textTheme;
    return BouncingButton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    color: NGTheme.purple1,
                    value: _skipValue,
                  ),
                  Positioned.fill(
                    top: 11,
                    left: 11,
                    child: Text(
                      '>>',
                      style: textTheme.displaySmall,
                    ),
                  )
                ],
              ),
            ),
          ),
          Text('Skip', style: textTheme.displaySmall)
        ],
      ),
    );
  }
}
