// admob_service.dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  // Singleton pattern
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal();

  // FOR TESTING - Use test ad units
  // Test ad units always work regardless of AdMob account setup
  static const String interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712"; // Test interstitial
  static const String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917"; // Test rewarded
  
  // Comment out your real IDs for now
  // static const String interstitialAdUnitId = "ca-app-pub-1993397054354769/8836766664";
  // static const String rewardedAdUnitId = 'ca-app-pub-1993397054354769/8836766664';

  // Ad instances
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  // Loading states
  bool _isInterstitialLoading = false;
  bool _isRewardedLoading = false;

  // Ad readiness states
  bool _isInterstitialReady = false;
  bool _isRewardedReady = false;

  // Getters
  bool get isInterstitialReady => _isInterstitialReady;
  bool get isRewardedReady => _isRewardedReady;
  bool get isInterstitialLoading => _isInterstitialLoading;
  bool get isRewardedLoading => _isRewardedLoading;

  // Initialize Ad Manager
  void initialize() {
    // Enable test mode and child-directed settings
    final RequestConfiguration requestConfiguration = RequestConfiguration(
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
      maxAdContentRating: MaxAdContentRating.g,
      // Add test devices if needed (you'll see device IDs in logs)
      testDeviceIds: ["33BE2250B43518CCDA7DE426D04EE231"], // Empty list means all requests are test requests with test ad units
    );
    MobileAds.instance.updateRequestConfiguration(requestConfiguration);
    
    debugPrint("AdManager: Initialized with test ad units");
  }

  // ============= INTERSTITIAL AD METHODS =============

  void loadInterstitialAd() {
    if (_isInterstitialLoading) return;
    
    _isInterstitialLoading = true;
    _isInterstitialReady = false;
    
    debugPrint("AdManager: Attempting to load interstitial ad with ID: $interstitialAdUnitId");
    
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoading = false;
          _isInterstitialReady = true;
          debugPrint("AdManager: Interstitial ad loaded successfully.");
          
          // Set up callbacks immediately
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint("AdManager: Interstitial ad dismissed.");
              ad.dispose();
              _interstitialAd = null;
              _isInterstitialReady = false;
              // Load next ad
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint("AdManager: Interstitial ad failed to show: $error");
              ad.dispose();
              _interstitialAd = null;
              _isInterstitialReady = false;
            },
            onAdShowedFullScreenContent: (ad) {
              debugPrint("AdManager: Interstitial ad showed successfully.");
            },
            onAdImpression: (ad) {
              debugPrint("AdManager: Interstitial ad impression recorded.");
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isInterstitialLoading = false;
          _isInterstitialReady = false;
          debugPrint("AdManager: Interstitial ad failed to load: $error");
          debugPrint("Error code: ${error.code}");
          debugPrint("Error message: ${error.message}");
          
          // Retry after delay
          Future.delayed(const Duration(seconds: 30), () {
            if (!_isInterstitialReady && !_isInterstitialLoading) {
              debugPrint("AdManager: Retrying interstitial ad load...");
              loadInterstitialAd();
            }
          });
        },
      ),
    );
  }

  void showInterstitialAd({
    VoidCallback? onAdDismissed,
    VoidCallback? onAdFailedToShow,
  }) {
    debugPrint("AdManager: Attempting to show interstitial ad.");
    
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      debugPrint("AdManager: Interstitial ad is not ready to be shown.");
      onAdFailedToShow?.call();
      // Load one for next time
      loadInterstitialAd();
    }
  }

  // ============= REWARDED AD METHODS =============

  void loadRewardedAd() {
    if (_isRewardedLoading) return;
    
    _isRewardedLoading = true;
    _isRewardedReady = false;

    debugPrint("AdManager: Attempting to load rewarded ad with ID: $rewardedAdUnitId");

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isRewardedLoading = false;
          _isRewardedReady = true;
          debugPrint('AdManager: Rewarded ad loaded successfully.');
          
          // Set up callbacks immediately
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) {
              debugPrint('AdManager: Rewarded ad showed successfully.');
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              debugPrint('AdManager: Rewarded ad dismissed.');
              ad.dispose();
              _rewardedAd = null;
              _isRewardedReady = false;
              // Reload the ad for future use
              loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              debugPrint('AdManager: Rewarded ad failed to show: $error');
              ad.dispose();
              _rewardedAd = null;
              _isRewardedReady = false;
            },
            onAdImpression: (ad) {
              debugPrint('AdManager: Rewarded ad impression recorded.');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isRewardedLoading = false;
          _isRewardedReady = false;
          debugPrint('AdManager: Rewarded ad failed to load: $error');
          debugPrint('Error code: ${error.code}');
          debugPrint('Error message: ${error.message}');
          
          // Retry after delay
          Future.delayed(const Duration(seconds: 30), () {
            if (!_isRewardedReady && !_isRewardedLoading) {
              debugPrint('AdManager: Retrying rewarded ad load...');
              loadRewardedAd();
            }
          });
        },
      ),
    );
  }

  void showRewardedAd({
    required VoidCallback onUserEarnedReward,
    VoidCallback? onAdDismissed,
    VoidCallback? onAdFailedToShow,
  }) {
    if (_rewardedAd == null) {
      debugPrint('AdManager: Attempt to show rewarded ad before it was loaded.');
      onAdFailedToShow?.call();
      // Load one for next time
      loadRewardedAd();
      return;
    }

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('AdManager: User earned reward: ${reward.amount} ${reward.type}');
        onUserEarnedReward.call();
      },
    );
  }

  // ============= UTILITY METHODS =============

  bool isAdRequired(List<int> selectedNumbers) {
    return selectedNumbers.any((num) => num > 6);
  }

  // Dispose all ads
  void disposeAll() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _interstitialAd = null;
    _rewardedAd = null;
    _isInterstitialReady = false;
    _isRewardedReady = false;
  }
}