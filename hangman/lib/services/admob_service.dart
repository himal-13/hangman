// lib/services/ad_service.dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  // Test IDs - Replace with your actual AdMob IDs before publishing
  // For iOS simulator and Android emulator, test ads will be shown automatically
  
  // MARK: - IMPORTANT: Replace these with your actual AdMob unit IDs before publishing
  
  // Test IDs (use these for development)
  static const String _testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
  
  static const String _bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Replace with your banner ad ID
  static const String _rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917'; // Replace with your rewarded ad ID
  
  // Use test IDs during development, switch to production IDs for release
  static bool get _useTestIds => true; // Set to false for production
  
  static String get bannerAdUnitId => _useTestIds ? _testBannerAdUnitId : _bannerAdUnitId;
  static String get rewardedAdUnitId => _useTestIds ? _testRewardedAdUnitId : _rewardedAdUnitId;

  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoading = false;
  int _rewardedAdLoadAttempts = 0;
  static const int maxRewardedAdLoadAttempts = 3;

  // Callbacks
  VoidCallback? _onAdLoaded;
  Function(RewardedAd)? _onUserEarnedReward;
  Function(Object?)? _onAdFailedToLoad;

  /// Initialize mobile ads
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
    
    // Configure for child-directed content (important for kid-friendly app)
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
        tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
        maxAdContentRating: MaxAdContentRating.g,
      ),
    );
    
    debugPrint('AdMob initialized with child-friendly settings');
  }

  /// Load a rewarded ad
  void loadRewardedAd({
    VoidCallback? onAdLoaded,
    Function(RewardedAd)? onUserEarnedReward,
    Function(Object?)? onAdFailedToLoad,
  }) {
    if (_isRewardedAdLoading) {
      debugPrint('Rewarded ad is already loading');
      return;
    }

    _onAdLoaded = onAdLoaded;
    _onUserEarnedReward = onUserEarnedReward;
    _onAdFailedToLoad = onAdFailedToLoad;

    _isRewardedAdLoading = true;

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(
        // Kid-friendly ad request
        keywords: ['kids', 'educational', 'game', 'puzzle'],
        contentUrl: 'https://your-app-url.com', // Update this
        nonPersonalizedAds: true, // Important for kids
      ),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('Rewarded ad loaded successfully');
          _rewardedAd = ad;
          _isRewardedAdLoading = false;
          _rewardedAdLoadAttempts = 0;
          
          _onAdLoaded?.call();
          
          // Set full screen content callback
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Rewarded ad showed full screen content');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Rewarded ad dismissed');
              ad.dispose();
              loadRewardedAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Rewarded ad failed to show: $error');
              ad.dispose();
              loadRewardedAd(); // Try to load another ad
            },
            onAdImpression: (ad) {
              debugPrint('Rewarded ad impression recorded');
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _rewardedAd?.dispose();
          _rewardedAd = null;
          _isRewardedAdLoading = false;
          _rewardedAdLoadAttempts++;
          
          _onAdFailedToLoad?.call(error);
          
          // Retry loading if under max attempts
          if (_rewardedAdLoadAttempts < maxRewardedAdLoadAttempts) {
            loadRewardedAd();
          }
        },
      ),
    );
  }

  /// Show rewarded ad
  void showRewardedAd({
    required Function() onUserEarnedReward,
    Function()? onAdFailed,
  }) {
    if (_rewardedAd == null) {
      debugPrint('Rewarded ad is not ready yet');
      onAdFailed?.call();
      return;
    }

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('User earned reward: ${reward.amount} ${reward.type}');
        onUserEarnedReward.call();
      },
    );

    _rewardedAd = null; // Set to null so we don't try to show it again
  }

  /// Check if rewarded ad is ready
  bool get isRewardedAdReady => _rewardedAd != null;

  /// Dispose ads
  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}

// Banner Ad Widget for kid-friendly placement
class KidFriendlyBannerAd extends StatefulWidget {
  final double height;
  
  const KidFriendlyBannerAd({super.key, this.height = 50});

  @override
  State<KidFriendlyBannerAd> createState() => _KidFriendlyBannerAdState();
}

class _KidFriendlyBannerAdState extends State<KidFriendlyBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdService.bannerAdUnitId,
      request: const AdRequest(
        nonPersonalizedAds: true,
        keywords: ['kids', 'educational', 'game'],
      ),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Banner ad loaded');
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed to load: $error');
          ad.dispose();
          setState(() {
            _isAdLoaded = false;
          });
        },
        onAdImpression: (ad) {
          debugPrint('Banner ad impression');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) {
      return SizedBox(height: widget.height);
    }

    return Container(
      height: widget.height,
      color: Colors.grey.shade50,
      child: Center(
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}