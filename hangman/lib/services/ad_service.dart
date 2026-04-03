import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdMobService {
  // Test ad unit IDs (use these for testing)
  static const String _rewardedAdUnitId = 'ca-app-pub-1993397054354769/6438251224'; // Test ad unit ID ca-app-pub-3940256099942544/5224354917
  // Replace with your actual ad unit IDs when ready for production:
  // static const String _rewardedAdUnitId = 'ca-app-pub-YOUR_ID/YOUR_AD_UNIT_ID';
  
  static RewardedAd? _rewardedAd;
  static bool _isChildDirected = true; // Set to true for child-directed content
  
  static Future<void> initialize() async {
    // Set the app to be treated as child-directed
    final requestConfiguration = RequestConfiguration(
      tagForChildDirectedTreatment: _isChildDirected ? TagForChildDirectedTreatment.yes : TagForChildDirectedTreatment.unspecified,
      tagForUnderAgeOfConsent: _isChildDirected ? TagForUnderAgeOfConsent.yes : TagForUnderAgeOfConsent.unspecified,
      maxAdContentRating: MaxAdContentRating.g, // G-rated ads only (suitable for children)
    );
    
    await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
    await MobileAds.instance.initialize();
  }
  
  static Future<void> loadRewardedAd() async {
    await _rewardedAd?.dispose();
    
    // Create ad request with child-directed settings
    final adRequest = AdRequest(
      // These parameters help ensure child-safe ads
      nonPersonalizedAds: _isChildDirected, // Use non-personalized ads for children
    );
    
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: adRequest,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          debugPrint('RewardedAd loaded successfully');
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }
  
  static Future<bool> showRewardedAd({
    required VoidCallback onRewarded,
    required VoidCallback onFailed,
  }) async {
    if (_rewardedAd == null) {
      await loadRewardedAd();
      if (_rewardedAd == null) {
        onFailed();
        return false;
      }
    }
    
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('Ad dismissed');
        ad.dispose();
        loadRewardedAd(); // Load next ad
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Failed to show ad: $error');
        ad.dispose();
        loadRewardedAd();
        onFailed();
      },
      onAdShowedFullScreenContent: (ad) {
        debugPrint('Ad showed successfully');
      },
    );
    
    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint('User earned reward: ${reward.amount} ${reward.type}');
        onRewarded();
      },
    );
    
    return true;
  }
  
  // Method to update child-directed setting (useful if your app has different user modes)
  static void setChildDirected(bool isChildDirected) {
    _isChildDirected = isChildDirected;
    // Re-initialize with new settings
    initialize();
  }
  
  // Method to check if ads are loaded and ready
  static bool isAdLoaded() {
    return _rewardedAd != null;
  }
  
  // Clean up resources when app is closed
  static void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}