import 'package:flutter/material.dart';
import 'package:hangman/services/ad_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hangman/audio/audio_manager.dart';

class GameSettingsProvider extends ChangeNotifier {
  static const String _coinsKey = 'coins_balance';
  static const String _soundMutedKey = 'sound_muted';
  static const String _lastClaimedDateKey = 'last_claimed_date';

  int _coins = 100; 
  bool _soundMuted = false;
  String _lastClaimedDate = '';

  int get coins => _coins;
  bool get isSoundMuted => _soundMuted;
  
  bool get canClaimDailyReward {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return _lastClaimedDate != today;
  }

  GameSettingsProvider() {
    loadSettings();
  }
  
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _coins = prefs.getInt(_coinsKey) ?? 100;
    _soundMuted = prefs.getBool(_soundMutedKey) ?? false;
    _lastClaimedDate = prefs.getString(_lastClaimedDateKey) ?? '';

    // Keep audio manager in sync with saved sound setting.
    AudioManager.instance.setMuted(_soundMuted);

    notifyListeners();
  }
  
  Future<void> spendCoins(int amount) async {
    if (_coins >= amount) {
      _coins -= amount;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_coinsKey, _coins);
      notifyListeners();
    }
  }

  Future<void> addCoins(int amount) async {
    _coins += amount;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinsKey, _coins);
    notifyListeners();
  }

  Future<bool> getCoinsViaRewardedAd(BuildContext context) async {
    // Show ad first, then give coins
    bool success = false;
    
    await AdMobService.showRewardedAd(
      onRewarded: () {
        // Add 20 coins when user watches the ad
        addCoins(20);
        success = true;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎉 You earned 20 Coins!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      onFailed: () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ad failed to load. Please try again.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
    
    return success;
  }

  Future<void> setSoundMuted(bool muted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundMutedKey, muted);

    _soundMuted = muted;
    AudioManager.instance.setMuted(muted);
    notifyListeners();
  }

  Future<void> claimDailyReward() async {
    if (canClaimDailyReward) {
      _coins += 20;
      _lastClaimedDate = DateTime.now().toIso8601String().split('T')[0];
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_coinsKey, _coins);
      await prefs.setString(_lastClaimedDateKey, _lastClaimedDate);
      
      notifyListeners();
    }
  }
}